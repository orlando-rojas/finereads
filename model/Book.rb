class Book < LazyRecord

    attr_accessor :title, :img_route, :author, :status, :date_added, :notes, :vol_id

    #@param title [String]
    #@param author [String]
    #@param status [String]
    #@param notes [String]
    #@param vol_id [String]
    def initialize(img_route, title, author, status, notes='', vol_id)
        @img_route = img_route
        @title = title
        @vol_id = vol_id
        @author = author
        @status = status
        @date_added = Date.today.strftime("%B %d, %Y")
        @notes = notes
    end
end

