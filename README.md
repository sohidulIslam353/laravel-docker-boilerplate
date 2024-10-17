This is just a boiler plate who are interested to make a laravel project by docker
Step you need to follow
1. Clone this repository
2. run the command ( docker-compose up -d)
3. for install a new  laravel project write the command -  (docker-compose run composer create-project laravel/laravel project-name)  also you can pass the laravel version here.

   Note: [ If you face any permission issue for making laravel project just first of all check the user you have write (whoami) comamnd for currnt user and if you see liek a name of you example: sohel or root or ubuntu just write the name on php.dockerfile on 
   ARG USER=name ]
after that you can create the project again.
