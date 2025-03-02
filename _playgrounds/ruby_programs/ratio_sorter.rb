#!/usr/bin/env ruby

require 'fileutils'
require 'mini_magick'
require 'gtk3'

# Define aspect ratios as constants
ASPECT_4_3 = 4.0 / 3.0
ASPECT_16_9 = 16.0 / 9.0

def sort_images_in_directory(dir_path, threshold: 0.05)
  four_by_three_folder  = File.join(dir_path, '4_3')
  sixteen_by_nine_folder = File.join(dir_path, '16_9')
  misc_folder = File.join(dir_path, 'misc')

  FileUtils.mkdir_p(four_by_three_folder)
  FileUtils.mkdir_p(sixteen_by_nine_folder)
  FileUtils.mkdir_p(misc_folder)

  # Extensions we look for
  image_extensions = %w[*.jpg *.jpeg *.png *.gif *.bmp *.JPG *.PNG *.jfif *.jpg_large]

  image_extensions.each do |pattern|
    Dir.glob(File.join(dir_path, pattern)).each do |filename|
      image = MiniMagick::Image.open(filename)
      width = image.width
      height = image.height
      next if width.nil? || height.nil? || height.zero?

      actual_ratio = width.to_f / height.to_f
      diff_4_3  = (actual_ratio - ASPECT_4_3).abs
      diff_16_9 = (actual_ratio - ASPECT_16_9).abs

      # Closer to 4:3 or 16:9?
      if diff_4_3 < diff_16_9
        # 4:3
        if diff_4_3 < threshold
          puts "Moving #{File.basename(filename)} => 4_3 (ratio: #{actual_ratio.round(2)})"
          FileUtils.mv(filename, four_by_three_folder)
        else
          puts "Moving #{File.basename(filename)} => misc (ratio: #{actual_ratio.round(2)})"
          FileUtils.mv(filename, misc_folder)
        end
      else
        # 16:9
        if diff_16_9 < threshold
          puts "Moving #{File.basename(filename)} => 16_9 (ratio: #{actual_ratio.round(2)})"
          FileUtils.mv(filename, sixteen_by_nine_folder)
        else
          puts "Moving #{File.basename(filename)} => misc (ratio: #{actual_ratio.round(2)})"
          FileUtils.mv(filename, misc_folder)
        end
      end
    end
  end
end

# ----------------------------------------------------------------------------
# GUI CODE (GTK3)
# ----------------------------------------------------------------------------
def show_gui
  # Create the main GTK Application
  app = Gtk::Application.new("com.example.aspectsorter", :flags_none)

  app.signal_connect "activate" do |application|
    # Build the main window
    window = Gtk::ApplicationWindow.new(application)
    window.title = "Aspect Ratio Sorter"
    window.default_width = 400
    window.default_height = 200

    vbox = Gtk::Box.new(:vertical, 10)
    vbox.margin = 10
    window.add(vbox)

    # Label explaining threshold
    info_label = Gtk::Label.new("Enter threshold (default 0.05) to define how 'close' to 4:3 or 16:9.\n" \
                                "e.g. 0.05 means ±5% around those aspect ratios.")
    info_label.wrap = true
    vbox.pack_start(info_label, :expand => false, :fill => false, :padding => 5)

    # Threshold row
    threshold_box = Gtk::Box.new(:horizontal, 5)
    threshold_label = Gtk::Label.new("Threshold:")
    threshold_entry = Gtk::Entry.new
    threshold_entry.text = "0.05"  # Default
    threshold_box.pack_start(threshold_label, :expand => false, :fill => false, :padding => 0)
    threshold_box.pack_start(threshold_entry, :expand => true, :fill => true, :padding => 0)
    vbox.pack_start(threshold_box, :expand => false, :fill => false, :padding => 5)

    # Directory row
    dir_box = Gtk::Box.new(:horizontal, 5)
    dir_label = Gtk::Label.new("Folder:")
    dir_entry = Gtk::Entry.new
    dir_entry.text = "."
    dir_button = Gtk::Button.new(label: "Browse")
    dir_button.signal_connect "clicked" do
      dialog = Gtk::FileChooserDialog.new(
        title: "Choose a Folder",
        parent: window,
        action: Gtk::FileChooserAction::SELECT_FOLDER,
        buttons: [["Open", Gtk::ResponseType::ACCEPT], ["Cancel", Gtk::ResponseType::CANCEL]]
      )
      if dialog.run == Gtk::ResponseType::ACCEPT
        dir_entry.text = dialog.filename
      end
      dialog.destroy
    end
    dir_box.pack_start(dir_label, :expand => false, :fill => false, :padding => 0)
    dir_box.pack_start(dir_entry, :expand => true, :fill => true, :padding => 0)
    dir_box.pack_start(dir_button, :expand => false, :fill => false, :padding => 0)
    vbox.pack_start(dir_box, :expand => false, :fill => false, :padding => 5)

    # Run sort button
    run_button = Gtk::Button.new(label: "Run Sort")
    run_button.signal_connect "clicked" do
      thr_value = threshold_entry.text.to_f
      dir_value = dir_entry.text.strip
      if dir_value.empty?
        show_message_dialog(window, "Error", "Please select a directory.")
      else
        begin
          sort_images_in_directory(dir_value, threshold: thr_value)
          show_message_dialog(window, "Done", "Finished sorting images in:\n#{dir_value}\n" \
                                              "Threshold used: #{thr_value}")
        rescue => e
          show_message_dialog(window, "Error", "Failed to sort images:\n#{e.message}")
        end
      end
    end
    vbox.pack_start(run_button, :expand => false, :fill => false, :padding => 10)

    window.show_all
  end

  app.run
end

def show_message_dialog(parent, title, message)
  dialog = Gtk::MessageDialog.new(
    transient_for: parent,
    flags: :modal,
    type: :info,
    buttons_type: :ok,
    message: message
  )
  dialog.title = title
  dialog.run
  dialog.destroy
end

# ----------------------------------------------------------------------------
# If we got a folder argument => CLI mode
# Otherwise => show GUI
# ----------------------------------------------------------------------------
if ARGV.empty?
  # No argument => Launch GUI
  show_gui
else
  # CLI usage: e.g. ruby ratio_sorter.rb /path/to/folder
  dir_path = ARGV.first || "."
  sort_images_in_directory(dir_path)
end
