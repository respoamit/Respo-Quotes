const quotesContainer = document.getElementById("quotes-container");
const quoteCount = document.getElementById("quoteCount");

let allQuotes = [];

async function loadQuotes() {

    try {

        const response = await fetch("api/quotes");

        allQuotes = await response.json();

        renderQuotes(allQuotes);

    } catch (error) {

        console.error(error);

        quotesContainer.innerHTML =
            "<h2>Unable to load quotes.</h2>";

    }

}

function renderQuotes(quotes) {

    quotesContainer.innerHTML = "";

    quoteCount.textContent = `${quotes.length} Quotes`;

    quotes.forEach((quote) => {

        quotesContainer.innerHTML += `

        <div class="quote">

            <blockquote>

                ${quote.text}

            </blockquote>

            <p class="author">

                — ${quote.author}

            </p>

        </div>

        `;

    });

}

loadQuotes();