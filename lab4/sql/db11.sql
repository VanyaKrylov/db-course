delete from game where price = (select max(price) from game);
delete from game where rating = (select min(rating) from game);
