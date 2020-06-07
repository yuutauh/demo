class BoardsController < ApplicationController

    def index
        @boards = Board.page(params[:page])
    end

    def new
        @board = Board.new(flash[:board])
    end

    def create
        board = Board.new(board_params)
        if board.save
            flash[:notice] = "#{board.title}を作成しました"
            redirect_to boards_path
        else
            redirect_to :back, flash: {
                board: board,
                error_messages: board.errors.full_messages
            }
        end
    end

    def show
        @board = Board.find(params[:id])
        
        @comment = Comment.new(board_id: @board.id)
    end

    def edit
        @board = Board.find(params[:id])
    end

    def update
        board = Board.find(params[:id])
        board.update(board_params)
        redirect_to board
    end
    
    def destroy
        board = Board.find(params[:id])
        board.destroy
        redirect_to boards_path, flash: { notice: "#{board.title}が削除されました" }
    end

    private

    def board_params
        params.require(:board).permit(:name, :title, :body)
    end
end
