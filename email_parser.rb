def parser
    start_number=0
    arr = Array.new
    @boundary_starting = false
    text=File.open('email.txt').read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
        # puts "#{start_number += 1} #{line}"     #was used for visual clarity
        # puts line.split(/: */)[1]               #was used for visual clarity
        arr << line if (line["To:"])
        arr << line if (line["From:"])
        arr << line if (line["Subject:"])
        arr << line if (line["Date:"])
        arr << line if (line["MIME-Version"])
        if (line["boundary="])
            @boundary = "--"+line[/boundary="(.*?)"/m, 1]
            puts @boundary
            puts "--------------"
        end
        if line["#{@boundary}"]
            if @boundary_starting == false
            @boundary_starting = true
            else
                @boundary_starting = false
            end
        else
            if @boundary_starting == true
                arr << line
            end    
        end
    end 
    puts "*********************"
    puts "*********************"
    puts "*********************"    
    puts arr    
end
parser()

