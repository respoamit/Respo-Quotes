async function loadFeaturedQuote() {

    const response = await fetch("data/quotes.json");

    const quotes = await response.json();

    const randomIndex = Math.floor(Math.random() * quotes.length);

    const quote = quotes[randomIndex];

    document.querySelector(".quote-card blockquote").innerHTML =
        quote.text;

    document.querySelector(".quote-card .author").innerHTML =
        "— " + quote.author;

}

loadFeaturedQuote();