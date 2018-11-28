INSERT INTO game
VALUES (DEFAULT, 'Red Dead Redemption', 1999, '01-01-2018', 8, 'english', 18, 1, 1, 1);

INSERT INTO system_requirements
VALUES (DEFAULT, 'Windows', 73, 'DirectX 13', 1, 1);

INSERT INTO developer
VALUES (DEFAULT, 'rockstar games' , '1990', 'rockstargames.com');

INSERT INTO DLC
VALUES (DEFAULT, 'Rancho shooting', 395, '02-02-2018', 'Дополнительные карты с сайд-квестами');

INSERT INTO minimal_requirements
VALUES (DEFAULT, 1, 1, 1);

INSERT INTO optimal_requirements
VALUES (DEFAULT, 1, 2, 2);

INSERT INTO CPU
VALUES (DEFAULT, 'Intel', 'i3', 4, 1.7, 1),
       (DEFAULT, 'Intel', 'i7', 8, 2.4, 2);

INSERT INTO OS
VALUES (DEFAULT, 'Windows', '7', 64);

INSERT INTO GPU
VALUES (DEFAULT, 'Nvidia', 'GeForce GTX1080', 2),
       (DEFAULT, 'Nvidia', 'RTX 2070', 8);
