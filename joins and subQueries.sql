-- FYI the information in the DB thet I am using has changed for some reason and now dose not match the videos.
-- for that reason my answers and methods may need to change.
-- host id and password from the source here: li2283-18.members.linode.com,  password withheld for security

--1. List all customers who live in Texas (use JOINs)
select first_name, last_name, customer_id, address
from customer
where address like '%TX%'
group by customer_id 
order by customer_id desc;
-- the answer I got back was 0 and there was no reason to use any joins because the address column
-- was in the customer table so all I had to do was know the input syntax and search for the abreviation
-- It would have been unnecessary and inefficent to use joins for such a simple query

--2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, final_total
from customer
full join cart
on customer.customer_id = cart.customer_id 
full join order_
on cart.cart_id = order_.cart_id 
where final_total > 6.99;

--I'm not sure if I'm supposed to be giving answers but I got three people from my Query


--3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name, customer_id
from customer
where customer_id in(
	select customer_id 
	from cart
	where cart_id in (
		select cart_id
		from order_
		group by cart_id
		having sum(final_total) > 175
		order by sum(final_total) desc
	)
);

--select * from order_;
-- Got none again because there are only three transactions in the order_ table and they dont total upto 175


--4. List all customers that live in Nepal (use the city table)
-- I already know that there are none that live in nepal because there are only 3 customers and they're all form MI
-- also I dont have a city table. but if I were to go looking for such a thing in what I'm guessing would be the right DB....
select customer.first_name, customer.last_name, country
from customer
full join address
on customer.address_id = address.address_id 
full join city
on address.ctiy_id = city.city_id 
full join country
on city.country_id = country,country_id
where country = 'Nepal'
group by last_name, first_name;

-- I believe this code would work


--5. Which staff member had the most transactions?
-- hmm, looks like i dont have any staff names dont know how to simulate what youre looking for here 
-- so how about the customer that paid the most in one order?
select customer.first_name, customer.last_name, max(final_total)
from customer
full join cart
on customer.customer_id = cart.customer_id 
full join order_
on cart.cart_id = order_.cart_id
group by customer.first_name, customer.last_name
order by max(final_total) desc;

-- oooo it's Raven Moc	with a wopping $23.49
-- working with what I got here

--6. How many movies of each rating are there?

--select * from movies;
-- oh this should be fun
select count(distinct(movie_rating))
from movies
group by movie_rating;

-- one of each(there are only 2 movies)

--7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name, customer_id
from customer
where customer_id in(
	select customer_id 
	from cart
	where cart_id in (
		select cart_id
		from order_
		group by cart_id, final_total
		having final_total > 6.99
		order by final_total desc
	)
);

--8, How many free rentals did our stores give away?
-- zero! this is obviously a theater and they do not do rentals.