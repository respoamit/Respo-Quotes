const searchBox = document.getElementById("searchBox");

searchBox.addEventListener("input", function () {

    const keyword = this.value.toLowerCase();

    const filteredQuotes = allQuotes.filter((quote) => {

        return (

            quote.text.toLowerCase().includes(keyword) ||

            quote.author.toLowerCase().includes(keyword) ||

            quote.category.toLowerCase().includes(keyword)

        );

    });

    renderQuotes(filteredQuotes);

});