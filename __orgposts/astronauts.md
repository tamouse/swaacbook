
# Table of Contents

1.  [Astronauts JavaScript example](#orgec144e8)


<a id="orgec144e8"></a>

# Astronauts JavaScript example

A small example of using JavaScript

    <!DOCTYPE html>
    <html>
        <head>
    	<meta charset="utf-8">
    	<title>Sorting a list of Women Astronauts, by Last Name</title>
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" media="screen" />
    	<style>
    	 body > section > script {
    	     font-family: monospace;
    	     display: block;
    	     white-space: pre;
    	 }
    	</style>
        </head>
        <body>
    	<header class="container">
    	    <h2 class="page-header"><script>document.write(document.title)</script></h2>
    	</header>
    	<section>
    	    <script>
    	     var womenInSpace = [
    		 "Valentina Tereshkova",
    		 "Svetlana Savitskaya",
    		 "Sally Ride",
    		 "Mae Jemison",
    		 "Eileen Collins",
    		 "Kalpana Chawla",
    		 "Christa McAuliffe",
    		 "Barbara Morgan",
    		 "Chiaki Mukai",
    		 "Laurel Clark",
    		 "Samantha Cristoforetti",
    		 "Liu Yang",
    		 "Peggy Whitson",
    		 "Judith Resnik"
    	     ];
    
    
    	     function reverseName(name) {
    		 return name.split(' ').
    			     reverse().
    			     join(', ');
    	     }
    
    	     function reverseNames(names) {
    		 var revNames = [];
    		 names.forEach(function (el) {
    		     revNames.push(reverseName(el));
    		 });
    		 return revNames;
    	     }
    
    	     function alphabetizer(names) {
    		 return reverseNames(names).sort();
    	     }
    
    	     document.write(
    		 '<section class="container">' +
    		 "<h3>Women in Space</h3>" +
    		 "<ul>" +
    		 alphabetizer(womenInSpace).map(function(astro) {
    		     return "<li>" + astro + "</li>";
    		 }).join("") +
    		 "</ul>" +
    		 '</section>'
    	     );
    
    	    </script>
    	</section>
        </body>
    </html>

