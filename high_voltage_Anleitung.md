Im gesamten Projekt ist auf folgendes zu achten. 

Alle links sind grundsätzlich ohne Endung anzugeben. Das bedeutet wer bspw. von der Login Page auf die Index Page linken will schreibt nicht
"a href = 'index.html.erb'" sondern lediglich "a href = 'index'".

Wer aus Programmcode linken will macht dies durch:

link_to 'Page', page_path('page'). Erneut ohne Endung. 

Dies sind dann beispielsweise so aus, wenn man zur "about"-Page linken will.
link_to 'About', page_path('about')

Ebenso erreicht man die gewünschten Seiten einfach über die Eingabe des statischen Teils (im Testumfeld localhost:3000) und der Ergänzung /page.

Wer also die Login-Page besuchen will gibt im Testumfeld ein: localhost:3000/login 


Fertige Views: 
Index
Login
Register
Calendar

____
Stand 11.01.14 - Myles 
