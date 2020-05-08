class Book < LazyRecord

    attr_accessor :title, :img_route, :author, :status, :date_added, :notes

    def initialize(img_route, title, author, status)
        @img_route = img_route
        @title = title
        @author = author
        @status = status
        @date_added = Date.today.strftime("%B %d, %Y")
        @notes = ''
    end
end