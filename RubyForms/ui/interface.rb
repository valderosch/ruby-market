require 'tk'
require_relative 'uiconfig'

class RFormsController

  def initialize
    @root = TkRoot.new { title "#{app_name}" }
    @root.width = 1280
    @root.height = 720
    @root.resizable(false, false)

    @frame = TkFrame.new(@root) { background "#121212"  }.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)

    buttons = ["Bot", "Stats", "Input Data", "Output Data", "Clients"]

    @aside = TkFrame.new(@frame){background '#212121'}.place(relx: 0, rely: 0, relwidth: 0.25, relheight: 1)

    buttons.each_with_index do |button_name, index|
      TkButton.new(@aside) do
        text button_name
        bg "#535353"
        fg "#ffffff"
        bd 0
        padx 10
        anchor 'w'
        font TkFont.new(family: "Arial", size: 14)
        command lambda { change_content(button_name) }
      end.place(relx: 0.025, rely: 0.02 + (index * 0.1), relwidth: 0.95, relheight: 0.1)
    end

    TkButton.new(@aside) do
      text "Exit"
      font TkFont.new(family: "Arial", size: 14, weight: "bold")
      bg "#535353"
      fg "#212121"
      bd 0
      activeforeground "#101010"
      command proc { exit }
    end.place(relx: 0, rely: 0.95, relwidth: 1, relheight: 0.05)
  end

  def change_content(content)
    @content_frame.destroy if defined? @content_frame
    @content_frame = TkFrame.new(@root) { background '#fff' }.place(relx: 0.25, rely: 0.1, relwidth: 0.7, relheight: 0.7)

    case content
    when "Bot"
      TkFrame.new(@content_frame) { text "Bot control pnel" }.place(relx: 0.1, rely: 0.1, relwidth: 0.8, relheight: 0.1)
    when "Stats"
      TkFrame.new(@content_frame) { text "Program real time stats" }.place(relx: 0.1, rely: 0.1, relwidth: 0.8, relheight: 0.1)
    when "Input Data"
      TkFrame.new(@content_frame) { text "Input data frame" }.place(relx: 0.1, rely: 0.1, relwidth: 0.8, relheight: 0.1)
    when "Output Data"
      TkFrame.new(@content_frame) { text "Output DB" }.place(relx: 0.1, rely: 0.1, relwidth: 0.8, relheight: 0.1)
    when "Clients"
      TkFrame.new(@content_frame) { text "Clients" }.place(relx: 0.1, rely: 0.1, relwidth: 0.8, relheight: 0.1)
    end
  end

  def run
    Tk.mainloop
  end
end

RFormsController.new.run