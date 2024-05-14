require 'tk'
require 'yaml'

class RFormsController
  def config
    @config ||= YAML.load_file('E:/B.ProjectStore/Ruby/marketing/RubyForms/ui/uiconfiguration.yml')
  end

  def initialize
    @config = config
    @root = TkRoot.new(title: @config['app_name'])
    @root.width = @config['app_win_width']
    @root.height = @config['app_win_height']
    @root.resizable(false, false)

    @frame = TkFrame.new(@root) { background "#121212"  }.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)

    buttons = %w[Bot Stats Clients]

    @aside = TkFrame.new(@frame){background '#212121'}.place(relx: 0, rely: 0, relwidth: 0.25, relheight: 1)

    @tabs = {}

    buttons.each_with_index do |button_name, index|
      @tabs[button_name] = TkButton.new(@aside) do
        text button_name
        bg "#535353"
        fg "#ffffff"
        bd 0
        padx 10
        anchor 'w'
        font TkFont.new(family: "Arial", size: 14)
      end.place(relx: 0.025, rely: 0.02 + (index * 0.1), relwidth: 0.95, relheight: 0.1)

      @tabs[button_name].bind("ButtonRelease-1") { change_content(button_name) }
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

  def handle_button_click(text, logs_text)
    case text
    when "▶"
      add_to_logs(logs_text, "bot start")
    when "∥"
      add_to_logs(logs_text, "bot pause")
    when "↻"
      add_to_logs(logs_text, "bot restart")
    when "⊘"
      add_to_logs(logs_text, "bot shut down")
    end
  end

  def add_to_logs(logs_text, message)
    time = Time.now.strftime("%H:%M:%S")
    logs_text.insert('end', "#{time} | #{message}\n")
    logs_text.see('end')
  end

  # TABS
  def create_bot_content(frame)
    content_frame = TkFrame.new(frame) { background '#212121' }
    content_frame.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)

    TkLabel.new(content_frame) do
      text "BOT"
      foreground  "#fff"
      background "#212121"
      font TkFont.new(family: "Arial", size: 14, weight: "bold")
      anchor 'w'
    end.place(relx:0.02, rely:0, relwidth:0.9, relheight:0.1)

    info_frame = TkFrame.new(content_frame) do
      background "#212121"
      borderwidth 3
      relief 'ridge'
      highlightbackground '#ffffff'
    end.place(relx:0.01, rely:0.14, relwidth:0.48, relheight:0.65)

    logs_frame = TkFrame.new(content_frame) do
      background "#121212"
      borderwidth 3
      relief 'ridge'
    end.place(relx:0.5, rely:0.14, relwidth:0.48, relheight:0.65)

    logs_text = TkText.new(logs_frame) do
      background "#121212"
      foreground "#ffffff"
      borderwidth 0
      font TkFont.new(family: "Consolas", size: 12)
    end.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)

    control_frame = TkFrame.new(content_frame) do
      background "#000"
    end.place(relx:0.01, rely:0.87, relwidth:0.98, relheight:0.12)

    button_texts = ["▶", "∥", "↻", "⊘"]
    button_coordinates = [[0.39, 0.4], [0.47, 0.4], [0.55, 0.4], [0.92, 0.4]]

    button_texts.each_with_index do |text, index|
      TkButton.new(control_frame) do
        text text
        font TkFont.new(family: "Consolas", size: 16, weight: 'bold')
        bg "#000"
        border 0
        foreground "#fff"
        command -> { handle_button_click(text, logs_text) }
      end.place(relx: button_coordinates[index][0], rely: button_coordinates[index][1], relwidth: 0.05, relheight: 0.2)
    end
  end

  def create_stats_content(frame)
    content_frame = TkFrame.new(frame) { background '#212121' }.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)
    TkLabel.new(content_frame) do
      text "Statistic"
      foreground  "#fff"
      background "#212121"
      font TkFont.new(family: "Arial", size: 14, weight: "bold")
      anchor 'w'
    end.place(relx:0.02, rely:0, relwidth:0.9, relheight:0.1)
  end

  def create_clients_content(frame)
    content_frame = TkFrame.new(frame) { background '#212121' }.place(relx: 0, rely: 0, relwidth: 1, relheight: 1)
    TkLabel.new(content_frame) do
      text "Clients"
      foreground  "#fff"
      background "#212121"
      font TkFont.new(family: "Arial", size: 14, weight: "bold")
      anchor 'w'
    end.place(relx:0.02, rely:0, relwidth:0.9, relheight:0.1)

  end

  # Tabs picker
  def change_content(content)
    @content_frame.destroy if defined? @content_frame
    @content_frame = TkFrame.new(@root) { background '#fff' }
    @content_frame.place(relx: 0.26, rely: 0.02, relwidth: 0.73, relheight: 0.96)

    send("create_#{content.downcase}_content", @content_frame) if respond_to?("create_#{content.downcase}_content")
  end

  def run
    Tk.mainloop
  end
end

RFormsController.new.run