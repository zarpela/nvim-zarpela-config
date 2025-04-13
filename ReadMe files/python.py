import requests

# Function to fetch books from Google Books API based on a search query
def fetch_books(query):
    url = 'https://www.googleapis.com/books/v1/volumes?q={query}'
    response = requests.get(url)

    if response.status_code == 200:
        books = response.json().get('items', [])
        if not books:
            print("No books found for this query.")
        else:
            for i, book in enumerate(books, start=1):
                volume_info = book['volumeInfo']
                title = volume_info.get('title', 'No title available')
                authors = ', '.join(volume_info.get('authors', ['No authors available']))
                description = volume_info.get('description', 'No description available')
                print(f"\nBook {i}:")
                print(f"Title: {title}")
                print(f"Authors: {authors}")
                print(f"Description: {description[:200]}...")  # Print first 200 chars of description
                print("-" * 40)
    else:
        print("Error fetching data from API")

# Main function
def main():
    query = input("Enter a book search query (e.g., 'Python programming'): ")
    fetch_books(query)

if __name__ == "__main__":
    main()

