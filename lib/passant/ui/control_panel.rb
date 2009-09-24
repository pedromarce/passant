module Passant::UI
  class ControlPanel < Wx::Panel
    def initialize(parent, board_panel)
      super(parent)
      @board_panel = board_panel
      
      take_back_b = Wx::Button.new(self, Wx::ID_ANY, '<')
      undo_takeback_b = Wx::Button.new(self, Wx::ID_ANY, '>')

      sizer = Wx::BoxSizer.new(Wx::HORIZONTAL)
      sizer.add(take_back_b)
      sizer.add(undo_takeback_b)
      
      set_sizer(sizer)
      
      evt_button(take_back_b.id)     { |event| take_back }
      evt_button(undo_takeback_b.id) { |event| undo_takeback }
    end

    private

    
    def take_back
      mv = @board_panel.board.take_back
      if mv
        mv.draw
        parent.set_status("Took back #{mv}.")
      end
    end

    def undo_takeback
      mv = Wx::get_app.responsively do
        @board_panel.board.undo_takeback
      end
      
      if mv
        mv.draw
        parent.set_status(mv.to_s)
      end
    end
  end
end
