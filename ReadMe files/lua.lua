-- Load required libraries
local http = require("socket.http")
local url = require("socket.url")  -- For URL encoding
local json = require("dkjson")

-- Function to fetch books from Google Books API based on a search query
function fetch_books(query)
    -- URL encode the query to handle special characters and spaces
    local encoded_query = url.escape(query)
    local url = "https://www.googleapis.com/books/v1/volumes?q=" .. encoded_query

    local response, status = http.request(url)

    print("Status Code: " .. status)  -- Print the status code
    if status == 200 then
        local books_data = json.decode(response)
        local books = books_data.items

        if not books then
            print("No books found for this query.")
        else
            for i, book in ipairs(books) do
                local volume_info = book.volumeInfo
                local title = volume_info.title or "No title available"
                local authors = table.concat(volume_info.authors or {"No authors available"}, ", ")
                local description = volume_info.description or "No description available"
                description = description:sub(1, 200)  -- Print first 200 chars of description

                print(string.format("\nBook %d:", i))
                print("Title: " .. title)
                print("Authors: " .. authors)
                print("Description: " .. description .. "...")
                print(string.rep("-", 40))
            end
        end
    else
        print("Error fetching data from API. Status code: " .. status)
        print("Response: " .. (response or "No response"))
    end
end

-- Main function
function main()
    io.write("Enter a book search query (e.g., 'Lua programming'): ")
    local query = io.read()
    fetch_books(query)
end

-- Run the main function
main()

