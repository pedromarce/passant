require 'passant/board'

describe Passant::Board do
  
  describe "#set" do
    it "should set pieces in place" do
      board = Passant::Board.new_empty
      board.pieces.size.should == 0
      board.set(['........', 
                 '........', 
                 '........', 
                 '....R...',
                 '........', 
                 '........', 
                 '........', 
                 '........'])
      board.pieces.size.should == 1
      p = board.pieces.first
      p.class.should == Passant::Rook
      p.color.should == :white
      p.position.should == e5
    end
  end
  
  describe "#move" do
    it "should make a valid move" do
      b = Passant::Board.new
      b.move(a2,a4)
      b.at(a4).class.should == Passant::Pawn
    end
    
    it "should raise InvalidMove if nothing to move" do
      b = Passant::Board.new
      lambda { b.move(a3,a4) }.should raise_error Passant::Move::Invalid
    end

    it "should raise InvalidMove if invalid move for piece" do
      b = Passant::Board.new
      b.at(a2).class.should == Passant::Pawn
      lambda { b.move(a2,a5) }.should raise_error Passant::Move::Invalid
    end
    
    it "should not recurse infinitely with castling (1)" do
      board = Passant::Board.new_empty
      board.set(['r....rk.',
                 '.bqn.pbp',
                 'p....np.',
                 '.p..p...',
                 '....P..Q',
                 'P.NB.N..',
                 '.PP...PP',
                 'R.B..R.K'])
      board.move('Bh6')
    end
    
    it "should not recurse infinitely with castling (2)" do
      board = Passant::Board.new_empty
      board.set(['r..qk..r',
                 '.p..bppp',
                 'p..pbn..',
                 '....p.B.',
                 '..P.P...',
                 '.PNQ....',
                 'P...BPPP',
                 'R...K..R'])
      board.move('O-O')
    end

  end

end
