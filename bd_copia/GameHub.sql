--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-05-26 09:33:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4874 (class 0 OID 24864)
-- Dependencies: 228
-- Data for Name: carrito_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrito_producto (id, carrito_id, producto_id, cantidad, created_at, updated_at) FROM stdin;
8	2	11	1	2025-05-12 11:18:03	2025-05-12 11:18:03
\.


--
-- TOC entry 4872 (class 0 OID 24848)
-- Dependencies: 226
-- Data for Name: carritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carritos (id, usuario_id, created_at, updated_at) FROM stdin;
1	01234567J	2025-05-12 09:00:55	2025-05-12 09:00:55
2	34567890C	2025-05-12 11:16:21	2025-05-12 11:16:21
\.


--
-- TOC entry 4861 (class 0 OID 16655)
-- Dependencies: 215
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre) FROM stdin;
1	Videojuegos
2	Consola
3	Merchandising
4	Cómic
\.


--
-- TOC entry 4863 (class 0 OID 16659)
-- Dependencies: 217
-- Data for Name: pedido_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedido_productos (id, pedido_id, producto_id, cantidad, precio_unitario, updated_at, created_at) FROM stdin;
71	17	11	1	46.90	2025-05-21 08:41:57	2025-05-21 08:41:57
72	17	12	8	41.99	2025-05-21 08:41:57	2025-05-21 08:41:57
73	17	15	1	79.99	2025-05-21 08:41:57	2025-05-21 08:41:57
74	17	14	2	429.99	2025-05-21 08:41:57	2025-05-21 08:41:57
83	20	11	1	46.90	2025-05-21 08:49:07	2025-05-21 08:49:07
84	20	12	8	41.99	2025-05-21 08:49:07	2025-05-21 08:49:07
85	20	15	1	79.99	2025-05-21 08:49:07	2025-05-21 08:49:07
86	20	14	2	429.99	2025-05-21 08:49:07	2025-05-21 08:49:07
87	21	11	1	46.90	2025-05-21 08:51:46	2025-05-21 08:51:46
88	21	12	8	41.99	2025-05-21 08:51:46	2025-05-21 08:51:46
89	21	15	1	79.99	2025-05-21 08:51:46	2025-05-21 08:51:46
90	21	14	2	429.99	2025-05-21 08:51:46	2025-05-21 08:51:46
91	22	14	1	429.99	2025-05-21 08:53:30	2025-05-21 08:53:30
92	23	15	1	79.99	2025-05-21 08:56:02	2025-05-21 08:56:02
93	24	14	1	429.99	2025-05-21 09:00:00	2025-05-21 09:00:00
94	25	14	1	429.99	2025-05-21 09:00:15	2025-05-21 09:00:15
95	26	14	1	429.99	2025-05-21 09:01:44	2025-05-21 09:01:44
96	27	14	1	429.99	2025-05-21 09:43:22	2025-05-21 09:43:22
97	28	15	2	79.99	2025-05-21 09:45:47	2025-05-21 09:45:47
98	29	12	1	41.99	2025-05-21 09:48:46	2025-05-21 09:48:46
99	30	14	1	429.99	2025-05-21 11:16:25	2025-05-21 11:16:25
100	31	11	1	46.90	2025-05-26 07:19:34	2025-05-26 07:19:34
\.


--
-- TOC entry 4865 (class 0 OID 16664)
-- Dependencies: 219
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id, usuario_dni, fecha, created_at, updated_at, estado, detalles) FROM stdin;
21	01234567J	2025-05-21 08:51:46	\N	\N	Pendiente de Confirmación	\N
22	01234567J	2025-05-21 08:53:30	\N	\N	Pendiente de Confirmación	\N
23	01234567J	2025-05-21 08:56:02	\N	\N	Pendiente de Confirmación	\N
24	01234567J	2025-05-21 09:00:00	\N	\N	Pendiente de Confirmación	\N
25	01234567J	2025-05-21 09:00:15	\N	\N	Pendiente de Confirmación	\N
26	01234567J	2025-05-21 09:01:44	\N	\N	Pendiente de Confirmación	\N
27	01234567J	2025-05-21 09:43:20	\N	\N	Pendiente de Confirmación	\N
29	01234567J	2025-05-21 09:48:46	\N	\N	Pendiente de Confirmación	\N
17	01234567J	2024-05-21 08:41:57	\N	\N	Confirmado	\N
20	01234567J	2025-05-21 08:49:07	\N	\N	Cancelado	Siu
31	01234567J	2025-05-26 07:19:34	\N	\N	Confirmado	\N
30	01234567J	2025-05-21 11:16:25	\N	\N	Cancelado	Stock insuficiente
28	01234567J	2025-05-21 09:45:47	\N	\N	Confirmado	\N
\.


--
-- TOC entry 4870 (class 0 OID 16728)
-- Dependencies: 224
-- Data for Name: plataforma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma (plataforma_id, plataforma) FROM stdin;
1	Nintendo Switch
2	PS5
3	PS4
4	XBOX
5	PC
6	Digital
8	Nintendo Switch 2
7	Otro
\.


--
-- TOC entry 4867 (class 0 OID 16670)
-- Dependencies: 221
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, categoria_id, stock, fecha_lanz, valoracion, imagen, plataforma_id, valoruser) FROM stdin;
3	FIFA 24	Descubre una nueva era  de fútbol de nueva generación para The World's Game: más de 19 000 futbolistas con licencia, 700 equipos y 30 ligas en la experiencia futbolística más auténtica hasta la fecha.\r\n\r\nSiente cada partido como nunca antes con tres tecnologías de vanguardia que ofrecen un realismo sin parangón en todos los partidos: HyperMotionV, PlayStyles optimizado por Opta y el nuevo motor de Frostbite.	49.99	1	500	2023-09-22	7.8	images/caratulas/ps4/fifa-24.jpg	3	7.5
4	Super Mario Odyssey	El famoso fontanero vuelve a las plataformas 3D acompañado por un nuevo aliado muy poco convencional.\r\n\r\nAcompaña a Mario en una aventura en 3D enorme por todo el planeta usando sus nuevas habilidades para recoger lunas que servirán de combustible a tu aeronave, la Odyssey. ¡Y entretanto, rescata a la princesa Peach de las garras de Bowser!\r\n\r\nEsta aventura 3D de Mario de estilo "sandbox" —la primera desde Super Mario 64 en 1997 y Super Mario Sunshine para Game Cube en 2002— está llena a reventar de secretos y sorpresas. Y con los nuevos movimientos de Mario, como lanzamiento de sombrero, Salto Sombrero o captura, vivirás experiencias de juego como no has conocido nunca en un juego de Mario. ¡Prepárate para viajar a tierras extrañas más allá del Reino Champiñón!	39.99	1	493	2017-10-27	9.9	images/caratulas/nintendo switch/super-mario-odyssey.jpg	1	9.9
2	Elden Ring	Un juego de rol y acción ambientando en un mundo lleno de misterios y peligros que se presenta como el juego más grande de FromSoftware hasta la fecha y en donde tendrás que equiparte, luchar y sobrevivir para encumbrarte como señor del Círculo en las Tierras Intermedias.\n\n \n\nBienvenidos a un nuevo mundo creado por Miyazaki y George R. R. Martin, bienvenidos a Elden Ring, desarrollado por FromSoftware Inc. y producido por BANDAI NAMCO Entertainment Inc.\n\nLa Orden Dorada está rota. Álzate, Sinluz, y que la gracia te guíe para abrazar el poder del Círculo de Elden.	59.99	1	500	2022-02-25	9.9	images/caratulas/ps5/ER.jpg	2	9.9
1	The Legend of Zelda: Tears of the Kingdom	La secuela de The Legend of Zelda: Breath of the Wild ya está aqui para sumergirte en una enorme aventura.\n\nÚnete a Link en una nueva aventura donde no solo seguirás explorando la basta tierra de Hyrule sino que en esta entrega irás hasta el cielo y más allá. Esta vez Link tendrá que escalar hasta las alturas nunca antes vistas, en esta entrega se da una alta importancia al exploración de forma vertical.\n\nAdemás deberás de hacer uso de la nueva versión mejorada del paravela donde podrás sobrevolar Hyrule a gran velocidad y así abarcar más territorio. \n\nDe nuevo Link deberá enfrentarse a todas las adversidades que se encuentre por su camino para intentar salvar al reino de Hyrule de la más absoluta de las desgracias.	69.99	1	500	2023-05-12	9.9	images/caratulas/switch/ZTOTK.jpg	1	9.9
10	Stardew Valley	Te vas a vivir al valle… esa es tu principal misión en este bonito juego donde deberás aprender a llevar tu granja con éxito para conseguirte un futuro mejor. Acabas de heredar la vieja granja que tu abuelo tenía en Stardew Valley, así que decides comenzar una nueva vida con la ayuda de unas cuantas herramientas de segunda mano y un puñado de monedas.\n\n¿Podrás aprender a vivir de la tierra y convertir ese terreno tan descuidado en un hogar acogedor? No será fácil.	14.99	1	500	2016-02-26	8.7	images/caratulas/ps4/SV.jpg	3	8.9
12	Elden Ring Nightreigne	Une fuerzas con otros jugadores para enfrentarte a la amenaza de la noche y los peligros que trae consigo en un cooperativo para 3 jugadores.\r\n\r\nExplora el frondoso y misterioso mundo de las Tierras Intermedias en el aclamado mundo abierto de acción y aventura, enfrentándote a deidades, monstruos y bandidos como un Sinluz destinado a reclamar el título de Señor del Círculo.	41.99	1	0	2025-05-30	0.0	images/caratulas/xbox/ERN.jpg	4	0.0
11	Leyendas Pokémon: Z-A	¡En Ciudad Luminalia se está llevando a cabo un plan de desarrollo urbanístico! Su objetivo es convertir la urbe en un lugar que humanos y Pokémon puedan compartir. Poco después de llegar, deberás elegir entre uno de estos compañeros Pokémon para que se una a tu aventura: Chikorita, Tepig o Totodile.\n\nEn su compañía, podrás explorar las calles de la enorme ciudad o visitar las zonas salvajes, hábitats donde te toparás con Pokémon salvajes. Para atraparlos, apunta con cuidado y lánzales una Poké Ball o bien enfréntate a ellos con la ayuda de los Pokémon que formen parte de tu equipo.	46.90	1	496	2025-12-31	0.0	images/caratulas/switch/PKMLZA.jpg	1	0.0
8	Resident Evil 4 Remake	Vuelve a disfrutar de este survival horror con León S. Kennedy viajando a las entrañas de una aldea rural europea para encontrar una amenaza completamente diferente a la que se enfrentó en Raccoon City.\n\nEste título mantiene la esencia del original mientras usa el motor gráfico RE Engine para modernizar la jugabilidad, una historia reescrita y gráficos de última generación.	59.99	1	500	2023-03-24	9.9	images/caratulas/ps5/RE4R.jpg	2	9.9
6	Gran Turismo 7	Ya seas un corredor competitivo, un coleccionista, un perfeccionista, un diseñador, un fotógrafo o un entusiasta de los arcades, alimenta tu pasión por los coches con elementos inspirados en el pasado, el presente y el futuro de Gran Turismo.\n\nDesde los vehículos y circuitos más clásicos hasta la reincorporación del legendario modo Simulación GT, disfruta de las mejores funcionalidades de las anteriores entregas de la serie. Y, si te apasiona la velocidad, practica y compite en los Campeonatos FIA y en el modo Sport*.	59.99	1	498	2022-03-04	9.1	images/caratulas/ps5/TUR7.jpg	2	8.8
13	Vampire The Masquerade - Bloodlines 2	La mente creativa detrás del Bloodlines original, Brian Mitsoda, regresa como Diseñador Narrativo Jefe en Bloodlines 2, ofreciendo a los fans un verdadero sucesor del clásico de culto original. Nacido de un acto de insurrección vampírica, tu existencia prende una guerra de sangre entre los clanes vampiros que controlan Seattle.\n\n \n\nPara sobrevivir, deberás escoger un clan y formar parte de tensas alianzas con otros clanes en un mundo que reaccionará a cada decisión que tomes. Desata tus poderes sobrenaturales contra tu presa, pero se consciente de tu alrededor en cada ocasión o correrás el riesgo de romper la Mascarada, la ley que mantiene en secreto a la sociedad de los vampiros de los humanos.	54.99	1	500	2025-12-31	0.0	images/caratulas/pc/VTMB2.jpg	5	0.0
9	Tekken 8	Vive el siguiente capítulo de la historia de este juego de lucha, entre el enfrentemamiento padre e hijo de Kazuya Mishima y Jin Kazama con tecnología de última generación para las nuevas consolas.\n\nDisfruta de gráficos de alta fidelidad, desarrollados para la nueva generación de hardware, para mostrar cada impacto y agresivos supermovimientos. Con una gran variedad de contenido para un jugador que explorar, como el nuevo modo Arcade Quest y un sistema de personalización en profundidad tanto para los personajes jugables como para los avatares	64.99	1	497	2024-01-26	8.9	images/caratulas/ps5/T8.jpg	2	8.1
5	Animal Crossing: New Horizons	En este juego, la línea que separa el interior del exterior se desdibuja por completo. Si ya no puedes más con el ajetreo de la ciudad, Tom Nook se ha sacado un negocio redondo de debajo de la manga y te tiene preparada una sorpresa que te encantará: ¡el Plan de Asentamiento en Islas Desiertas de Nook Inc.!\n\nHasta ahora has conocido a personajes de lo más variopinto, te lo has pasado de miedo en la gran ciudad y puede que hasta hayas decidido darle un giro a tu vida trabajando en la alcaldía. Sin embargo, hay una parte de ti que anhela… ¡la libertad en estado puro! Quieres hacer lo que te apetezca en cualquier momento. Quizá la solución sea darse un largo paseo por la playa de una isla desierta, en la que aguarda un verdadero tesoro de naturaleza virgen...	44.99	1	499	2020-03-20	9.1	images/caratulas/switch/ACNH.jpg	1	9.5
16	PlayStation 5	Adiós al misterio. PlayStation 5 ya está entre nosotros. Después de una campaña de marketing repleta de secretismo (no conocimos la fecha de lanzamiento o precio de la consola hasta hace tres meses), Sony por fin ha lanzado al mercado su nueva máquina. La compañía japonesa estrena su quinta generación de consolas de sobremesa, todo un hito que aquí no hemos querido dejar pasar.	549.99	2	500	2020-11-19	9.5	images/caratulas/consola/PS5.jpg	2	9.9
18	Stardew Valley	Te vas a vivir al valle… esa es tu principal misión en este bonito juego donde deberás aprender a llevar tu granja con éxito para conseguirte un futuro mejor. Acabas de heredar la vieja granja que tu abuelo tenía en Stardew Valley, así que decides comenzar una nueva vida con la ayuda de unas cuantas herramientas de segunda mano y un puñado de monedas.	25.99	1	500	2021-02-11	8.9	images/caratulas/nintendoswitch/SVSW.jpg	1	8.9
19	Pokémon: Leyendas Arceus	Leyendas Pokémon: Arceus es un videojuego de rol de acción desarrollado por Game Freak y publicado por The Pokémon Company y Nintendo para Nintendo Switch. Es parte de la octava generación de la serie de videojuegos Pokémon. Se trata de una precuela de los títulos Pokémon diamante y Pokémon perla, publicados en 2006.	48.99	1	500	2022-01-28	7.8	images/caratulas/nintendoswitch/PLA.jpeg	1	8.9
7	Hades	Compra Hades y lucha para escapar del infierno, un título que ha recibido más de 50 premios como juego del año. En este roguelike de mazmorras de los creadores de Bastion y Transistor, tendrás en tu mano los poderes y las armas míticas del Olimpo para liberarte de las garras del mismísimo dios de los muertos. Con cada intento de huida, irás haciéndote más fuerte y desentrañando los misterios de esta historia.	24.99	1	500	2020-09-17	9.1	images/caratulas/switch/HADES.jpg	1	9.4
15	Death Stranding 2: On The Beach 	Embárcate en una inspiradora misión de conexión humana más allá de las UCA emprendiendo un nuevo viaje, recorriendo un mundo asolado por enemigos sobrenaturales, obstáculos y una inquietante pregunta: ¿deberíamos haber conectado?\n\nLos vastos entornos en el mundo abierto de Death Stranding 2: On the Beach están llenos de secretos por descubrir, son increíblemente variados y ofrecen desafíos únicos que superar.	79.99	1	495	2025-06-26	0.0	images/caratulas/ps5/DE2.jpg	2	0.0
17	Super Smash Bros: Ultimate	¿Puede Link derrotar a Mario? ¿Puede Yoshi tumbar a Donkey Kong? ¿Puede Kirby darle una paliza a Pikachu? Descúbrelo en Super Smash Bros para Nintendo Switch, el juego de lucha más divertido de Nintendo, Hazte con él GAME.\n\nAntes de Super Smash Bros Melee para Nintendo Gamecube, estas y otras viejas preguntas encontraron respuesta inmediata con Super Smash Bros para Nintendo 64, el juego original de lucha por torneos con todas las estrellas de Nintendo. Así, podrás enfrentar entre sí a los personajes más populares de Nintendo.	59.99	1	500	2025-12-07	9.0	images/caratulas/switch/SSBU.jpg	1	9.5
14	Nintendo Switch 2	Nintendo Switch 2 ya es una realidad, y aunque de momento Nintendo no ha mostrado más que un vídeo en el que una Switch se transforma en su sucesora, también está empezando a enseñar su nueva consola a desarrolladores third-party. Por ahora los detalles oficiales son muy escasos, pero hemos recopilado todo lo que sabemos hasta el momento (con actualización asegurada) acerca de esa Nintendo Switch 2 que, de momento, tiene ese mismo nombre oficial.	429.99	2	0	2025-06-05	0.0	images/caratulas/consola/NS2.jpg	8	0.0
\.


--
-- TOC entry 4868 (class 0 OID 16677)
-- Dependencies: 222
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
1mppoRZgJEUkJ1ycWTjItgnCIc2LxSQcndMOatXU	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:137.0) Gecko/20100101 Firefox/137.0	YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0tqbVpYZDFoWDRBSFE5a052bXdUc1NCdWxYNDdsNlF5aGt5YWxkQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wcm9kdWN0b3MvbWVqb3Jlc3ZhbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1744010373
nB7siK1WBcYDFwgHGZCsKxzNxfV3QfC3sAVlJh5F	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:137.0) Gecko/20100101 Firefox/137.0	YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGNENjljbFlxNkY0dWFwN0FmcDVLOHE0UGIwZElDOUpodHpWMExlYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wcm9kdWN0b3MvcHJveGxhbnphbWllbnRvcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1744016082
\.


--
-- TOC entry 4869 (class 0 OID 16682)
-- Dependencies: 223
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (dni, nombre, apellidos, correo, telefono, tipouser, clave, usuario) FROM stdin;
74832667S	Sanctum	Sóez	xsanct@gmail.com	673414765	admin	$2y$12$mZH7Inldy7sTMqPapf1YoeZWzx8OZkyqrEBxnxTZJv3qYOjV6Pn9W	xSanctum
56327889L	SANCTUMERI	MARTINI	SANCTTT@gmail.com	673414765	usuario	$2y$12$BAI6NlpXTsRbJvP4CLF4reRvgc2yM.DBVyIQ4FhkvY3LRMC2kUAkC	Sanctum
01234567J	Miguel	Ángel	mgrandesanchez@gmail.com	602345678	admin	$2y$12$zyAcDaPVoXZVKvv3PzWYC.yECBidZzCHQ27o9V3iBpDqWmtRarO9e	xMigue29
47367886P	Prueba	Final	final@gmail.com	645367126	usuario	$2y$12$ny9OFB1Wk.etEYxjolIaLuVYolWwU5F7lFudajKWfSFhYKqwNjIvG	xFina
90123456I	Kirby	Ramírez	kirby@example.com	692345678	usuario	$2y$12$r90w0nsY5cIPeJsrCo3wgu6dmeAsrfPKm/J.1wTEbiPLWAqhN41C6	Kirby32
34567890C	Peach	Martínez	peach@example.com	632345678	usuario	$2y$12$271DoQKfidx0LihGpCOdA.v91hrkgMTj/RIbA9fEZkf0bDpszhPqm	Peach
45678901D	Bowser	Fernández	pllocru0706@gmail.com	642345678	usuario	$2y$12$O4JeNClbV8cAR6/ykpMPXuOb4J3yUy2utPCZAnwCA4PM5SgR.Tbcu	BowserFdezaAD
56789012E	Yoshie	Garcíaa	yoshi@example.com	652345678	usuario	$2y$12$qesJ4VjjRsbi8rMoTv6gz.TxREOMCZXZ0UiRZixBihINgAJyuaKBu	Yochii
\.


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 227
-- Name: carrito_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrito_producto_id_seq', 26, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 225
-- Name: carritos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carritos_id_seq', 2, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 216
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 218
-- Name: pedido_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedido_producto_id_seq', 100, true);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 220
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 31, true);


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 229
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 19, true);


-- Completed on 2025-05-26 09:33:31

--
-- PostgreSQL database dump complete
--

