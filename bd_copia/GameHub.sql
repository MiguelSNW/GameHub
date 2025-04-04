PGDMP  3    8                }           GameHub    16.8    16.8 -    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16439    GameHub    DATABASE     o   CREATE DATABASE "GameHub" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE "GameHub";
                postgres    false            �            1259    16655 
   categorias    TABLE     g   CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.categorias;
       public         heap    postgres    false            �            1259    16658    categorias_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categorias_id_seq;
       public          postgres    false    215            �           0    0    categorias_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;
          public          postgres    false    216            �            1259    16659    pedido_producto    TABLE     �   CREATE TABLE public.pedido_producto (
    id integer NOT NULL,
    pedido_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);
 #   DROP TABLE public.pedido_producto;
       public         heap    postgres    false            �            1259    16663    pedido_producto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pedido_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.pedido_producto_id_seq;
       public          postgres    false    217            �           0    0    pedido_producto_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.pedido_producto_id_seq OWNED BY public.pedido_producto.id;
          public          postgres    false    218            �            1259    16664    pedidos    TABLE     �   CREATE TABLE public.pedidos (
    id integer NOT NULL,
    usuario_dni character varying(9) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'pendiente'::character varying NOT NULL
);
    DROP TABLE public.pedidos;
       public         heap    postgres    false            �            1259    16669    pedidos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.pedidos_id_seq;
       public          postgres    false    219            �           0    0    pedidos_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;
          public          postgres    false    220            �            1259    16728 
   plataforma    TABLE     i   CREATE TABLE public.plataforma (
    plataforma_id integer NOT NULL,
    plataforma character varying
);
    DROP TABLE public.plataforma;
       public         heap    postgres    false            �            1259    16670 	   productos    TABLE     �  CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text NOT NULL,
    precio numeric(10,2) NOT NULL,
    categoria_id integer NOT NULL,
    stock integer DEFAULT 1 NOT NULL,
    fecha_lanz date NOT NULL,
    valoracion numeric(2,1) DEFAULT 0 NOT NULL,
    imagen character varying(500) NOT NULL,
    plataforma_id integer NOT NULL,
    valoruser numeric(2,1) DEFAULT 0 NOT NULL
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    16677    sessions    TABLE     �   CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);
    DROP TABLE public.sessions;
       public         heap    postgres    false            �            1259    16682    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    dni character varying(9) NOT NULL,
    usuario character varying(20) NOT NULL,
    clave character varying(20) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(50) NOT NULL,
    telefono integer NOT NULL,
    nivel integer DEFAULT 0 NOT NULL,
    tipouser character varying(10) NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            4           2604    16686    categorias id    DEFAULT     n   ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);
 <   ALTER TABLE public.categorias ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            5           2604    16687    pedido_producto id    DEFAULT     x   ALTER TABLE ONLY public.pedido_producto ALTER COLUMN id SET DEFAULT nextval('public.pedido_producto_id_seq'::regclass);
 A   ALTER TABLE public.pedido_producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217            7           2604    16688 
   pedidos id    DEFAULT     h   ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);
 9   ALTER TABLE public.pedidos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            �          0    16655 
   categorias 
   TABLE DATA           0   COPY public.categorias (id, nombre) FROM stdin;
    public          postgres    false    215   �5       �          0    16659    pedido_producto 
   TABLE DATA           `   COPY public.pedido_producto (id, pedido_id, producto_id, cantidad, precio_unitario) FROM stdin;
    public          postgres    false    217   M6       �          0    16664    pedidos 
   TABLE DATA           A   COPY public.pedidos (id, usuario_dni, fecha, estado) FROM stdin;
    public          postgres    false    219   �6       �          0    16728 
   plataforma 
   TABLE DATA           ?   COPY public.plataforma (plataforma_id, plataforma) FROM stdin;
    public          postgres    false    224   �7       �          0    16670 	   productos 
   TABLE DATA           �   COPY public.productos (id, nombre, descripcion, precio, categoria_id, stock, fecha_lanz, valoracion, imagen, plataforma_id, valoruser) FROM stdin;
    public          postgres    false    221   �7       �          0    16677    sessions 
   TABLE DATA           _   COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
    public          postgres    false    222   �J       �          0    16682    usuarios 
   TABLE DATA           m   COPY public.usuarios (dni, usuario, clave, nombre, apellidos, correo, telefono, nivel, tipouser) FROM stdin;
    public          postgres    false    223   �       �           0    0    categorias_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);
          public          postgres    false    216            �           0    0    pedido_producto_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.pedido_producto_id_seq', 17, true);
          public          postgres    false    218            �           0    0    pedidos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.pedidos_id_seq', 1, false);
          public          postgres    false    220            ?           2606    16690     categorias categorias_nombre_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);
 J   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_nombre_key;
       public            postgres    false    215            A           2606    16692    categorias categorias_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_pkey;
       public            postgres    false    215            C           2606    16694 $   pedido_producto pedido_producto_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pkey;
       public            postgres    false    217            E           2606    16696    pedidos pedidos_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public            postgres    false    219            O           2606    16734    plataforma plataforma_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT plataforma_pkey PRIMARY KEY (plataforma_id);
 D   ALTER TABLE ONLY public.plataforma DROP CONSTRAINT plataforma_pkey;
       public            postgres    false    224            G           2606    16698    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    221            J           2606    16700    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            postgres    false    222            M           2606    16702    usuarios usuarios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (dni);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    223            H           1259    16703    sessions_last_activity_index    INDEX     Z   CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
 0   DROP INDEX public.sessions_last_activity_index;
       public            postgres    false    222            K           1259    16704    sessions_user_id_index    INDEX     N   CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);
 *   DROP INDEX public.sessions_user_id_index;
       public            postgres    false    222            S           2606    16705    productos fk_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_categoria FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON DELETE SET NULL;
 @   ALTER TABLE ONLY public.productos DROP CONSTRAINT fk_categoria;
       public          postgres    false    215    221    4673            T           2606    16735    productos fk_plataforma    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_plataforma FOREIGN KEY (plataforma_id) REFERENCES public.plataforma(plataforma_id) NOT VALID;
 A   ALTER TABLE ONLY public.productos DROP CONSTRAINT fk_plataforma;
       public          postgres    false    224    4687    221            P           2606    16710 .   pedido_producto pedido_producto_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pedido_id_fkey;
       public          postgres    false    4677    217    219            Q           2606    16715 0   pedido_producto pedido_producto_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_producto_id_fkey;
       public          postgres    false    221    217    4679            R           2606    16720     pedidos pedidos_usuario_dni_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_usuario_dni_fkey FOREIGN KEY (usuario_dni) REFERENCES public.usuarios(dni) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_usuario_dni_fkey;
       public          postgres    false    223    219    4685            �   >   x�3��LI��*MM�/�2�t��+��I�2��M-J�H�K�,��K�2�t>�973�+F��� �t@      �   w   x�M�Q� C��0fQ����\�b4>��H��^��j�J��H����d�V�nP�Q���mY�S�������"� � -�v#�^(�7��� #r����^��]K)s�%[      �   �   x�m�I
A�u�^�%���9gp�t� ��x~m�Y>��! m��!.A�v��h����]�ӵnJ�v%Ҋ��<�)?�2��E�IiS$��H���C��k���H��|�Sb fv/������$���-0��"u��$��T���<ϕRo-�_      �   F   x�3����+I�K�W.�,I��2�6�2�&\&�N�\���\f�.��%�9\��%E�\1z\\\ 7fP      �      x��ZMsǵ]E'���!$EQ�EҖ"�RHZ)��i�4�&g���H�*�?d�7�J.\�y�*�䗼sn�A���Jd��}?�=�6��iY�Z��z�}S���̜*��T+��ܮ���&�ԍ�����U���4�,�lh��.ॅ)����Z��Qo_V���z��ַA�<�4��+�7m>jo�\�/���|��'-W6�.<�����.�o�@�-z�n���.�Wx��f�V�UQ�`�?:�#Ku���y[�N������W5��Lau~__+��X���L�uk�."�F�?l�֮􍾶��k��̨�!��"�z�&��7� "�a����M^������hs�V�8:;9z�Ύ��S��Ѷ�`nYO��h����u��f}�6z���S�h����e{3���+��V��j֮�L���o`e�n�
�+#�;��0�?f�l���w�����x?×���̄'9vkZ���"�?9=^-f٘+�v��^}u��{ى	yg��Z��!ϙ�n&�P��Lm(1�UD���w��⿂�ZW�y�7�0:T;;;j�r�-��;����� O%�$�ww�h�E#�|Z �ee�b}�븿n���Z>?�aq��aH70n�E�ɺ����(L�����ڕn���"�R׳V{D�8�M��c2"��	c�F�����c���:/<W/WP�k��?��R�.�U�ݢ�����ݢ��+�Hw���24ۘa��<=O�n�n������c��{��xO\��%�[�K��ώ]�����TN�r�?$�l=Ez�n@���]Ø�!���Z�s��a�" ��;\+�F��*��ܬ\]U��r �@�Ŭ�/���&���0p@�8?��#���C17�#������o�A�xW�jᢚ����P<f:�QY�^�P��:I��E��0T�I�"z�F�p���lE�9��3@
ۋy�|�@�Bp��"�m����0�碨���_w���rv����G���'/�NN/��#����ώj�f ������|T/����C�yE�5`� �j�S%�!Q���1����>Z/v�^i�_8~Q�޾ B`��0���3�ÕA��hy�۶��@]�J�9w�]_A��
�>$˭Cı�k���n��Y-d�T?�]h���<�a�k $�zG=W��B�cͭ��dVV\��z�DK���|D�?[^
��9@��C���	���j(��'��0��t�b~��:�"�tS��(e:ن%�VL�'!�W"�ぅ�%A[ͬ��H�%���a��C`W]�, o��QM��߱�kѥDc�4]�M������ʔ5$26[�wPk��"5*�v�Ә���@�.�:��%��ݠ2��0HjI@�A� ���2 �r����Z��1(.$%Ep�m!K�? !��5�����h
����)�F�R��nd/ێ��^�ɶ�5�X��W�X��LY����@~n��5r�pU�L$]}����w/�ݖs*�	KF$me<�.�-FA�R��ZJ\��6�zc��na,�ݺD���pI۬�p�\:K��`#����\��l�^O���s��A�|W"�6_��]��[�>[��(\����b���|����{)�b���ħx� �&B$t٩��V����&�7�}�s1����O4"^�Qe�"�#R�AKq��Jv���Q�d���XK���a}��=�.Z��-+2�ҝ�D�lIF(�B��l��"c!%?�	d�b,I�Т�U��V�n8<��E�ycc��N ,��0���S�	mfO;r��(���h�89M������}fn�e-0����]�
���H���\1ul���K�Ԓ�S`E�ůA힠�B}b�Mt��(���]�i]N��~E���{GR
�Ƀ�8!�7'ڎ�b`�6H�6ĐaNLl�"�r3�'v�|�L 	P�0i��&0�x�kH u;e��6f ,�J�D,T����9��{����G�pq��7��^?(��Q�HT,���Tj�>�Q�����WFp!`ѦϞ��D�����惋�s[�~���:n'�#㝝1�M��ΗZ ub\�c#]CW�Aо�텋�&�rK{�D�
��tE���fE̀t�BP�-1P��&`�:�7R��^��� �U���_��ރ��o��
K���U�<)�ư���0璑�s]-��G \��v�6F���G;���ͷ��6�m4�ޘPǽw��ϕ���ﶏ�_n��#)y�*�8$����`uz"�m��U�h�[?�ul��.Z�& �i[1A`)�X��R1	PK�O�w�	;"[b���!�pX��ϑ��(~p��_���~m�u�^����#薄����)9����Lriv�p�D�V��~�lD׸3�נ��
y�Cԝ2Qƾ�'�X�l����_fpL��-�C݄~f�Yh߱�^���H�+,C����82"U#,�L#ΐ�Z�6h���p�"Ն��raJ��\䚫��]��@�M�A6�����=� ��a���Ň��oF���o�|w����f_��^�^���[F���̳���
b�Q7�J���$�d��W_��,���q��O�qS�CKS4m�BT�Ҭ�݃4�dMAf�̄tV���M��*����F8�r�I�Iȟq�g�`�"%z7�F~� K3_�qbĴɭ�yJl���T���y�j���JU
=ȮX�.l?��__h���  B�{�THS�K�u�(M��Z���
�S��|�$$����J�i#���� C���W���,�}��M����gi^V��8�����41{6|��,;G�Qp�w����W��d:��Y�'\p�(�K�(�^B���.�굩kS�"�G-u�L����yC{�ٻ(�/��g���}\�0�7������f���_�k��
_\�D+��<w�߬���~���6�)ĉC�7c-PRGY�@v��9�����0u~�N�Y_�+lj{#���8���@��� G0�+<��%Y�\6p��(�ޱ��k�����A�����(�0�4��0ĳ샅#�C���q���sq_�e�6HŅ�hc�Hb]�	��c����Eo�ւ
U�����" o&C�4��=��k`�i�~���L(�����9ݞ�L|����ΛA�/N�P��Dϐ�$,��m0�8H��c�h1�t�t�{�ĝ[g�xcS�J栿�覥x�H0W���G��sCX����L���j�
y�*��Ɯ����S��Ҥ�f�B/���`�4�u{�;���S@�oD��LF[���������B*zPG���k�Ð�sP�F&o�u�SF�p����Xo{�Ѩ5�tdk�[��W1�֟?��� 42�I�Fp}����".�*E��5W��NF@ I��?�������F��e�Ml�e���4�׼B����4/P
�+JE�Q��xX� \��n�怶)5~���D�6l�<�:V��'�8��!���L����f;����:�<���t}��r��R������}���)�Ň4�F~>�6.�ԙ�́3vVg� Z9k�I7,�!�M��u����+]�H��2?I��{Ed�d& �S�9����޻����SU����6��ywwy�<r�J��K@aѭG��,^ ,ݗ�z6>�K�m�S�H>�<`�"�6��;A�i������L�0Zr�,p�=�_|y�	�:�>M�ug{w�q��	-���3q����n��M�����:��P��^��%�fPcc9�U	,O�4�*7�vUy�^�H�(.Mp�� ْ���}ғZu�)���f*lj��A��B�Ez�MuNXC�s�*�t�R �e3�I4�Q�K+����EN%�.a�o �'�P����r��2�zƒ*%Wx5�.A��]GrlI/`�&5g2L�v��&{�Sq*�x竫8)������&-�	����ؼ���lФY@��K�Q!Aᵴ��["c7�Q��XЩ-��dj�Kl�t	���Ǥ�+��^���(5�
�8t�I�8�)9�
�\��K"��{Fh�n1%��w�\:� �  ��s��A��$��4|��ɇ˷/ƒ4�1i����_4�O��ջZR�L���j��)�����YK�y$2~���Q� �7�G�T1�	"������YB+�4r��*��݈�p���hQLޖ��ȕ֌��s�˿c`�q����V�伍����@�-��,_�M������x2֩�oNy�B�\~-�dM��x����&����/��.��;|���
*M�������!�>eM|<@�NNǉEI(<�⽺�+��쨀/鿾�Ճ��)4��$�d]?8�'r���rc��MCcy#�սYd��ڥ�����F�~������w�����{���G ��灺p�JL>E[0�q+��/��MT	Q����P��'u���#�opa���:�8E�V,2�&�!A�;�Z07N:M]�#�_	8�t?�\a�~���=m�y[��SӹO�_�c�4r/;��6�2�A���L��4C�p���̲�sT��2�M]K�3�e=[�ƥ����� D����\/U=ڈ?�Z���zޤ~5����{��~�u��P��۬/+�2}�d.%	�8$t�ᬔ &�.8���I	�N! -����/]��F�6��:������h�4�4��ϊw_yjx����{�a�A��'_�$=j��w3�S|���߅���8���������^�,}      �      x�ܽ˒�ʶ%ؾ��Ӭ�d�D�eC���p���[u GB� $!���$��ǩN�ŭ�K�֊�����9�|wp'�0�wl]�Q;e��f�ZJE>�������o�o���O��G�7�:]8O������ѥe�����!���/��_X*����?���%���$��������gI�����r/N��?���%�:�m?�U��qMȤ�g��*���g\/i�״�ha�jڒ�s)wؘ��
d���ء1��A���p ���ϫ��=��Y�_,�.�d.=�}}o��'��p�eo�U�rהs6��[{d(3�|�r����mw�S�-Au��}$1���ݲ����zɤ����6�k��<��;U�޻�������)�뿉+EV�X���6�z�7A�y��['pc�/�߫�<+y\ծP^>AB�}�iO0-S3�2CQ�a�	2�	���`J�ф����h��!�W��u�Uk���`���i��K���i��&#?�����a|[Pa���Ra'@DI�D�%��ZLÉ��<���G��F���V ���m��f2�{e�e��s���_�z�������/"��]�݉�J�b$���Qe'I_}�@Ǽ�i�!}ʭ]h����@ �#i&��XQ	֬D$V����L޷���H�����]�y��y���/Z�zW������DXmb��CR 6;+�:�Ğ	���Pǵ��Oe��`����\4�P�Nk�(�=m��,&GGV���vHO~�Y���:�|����،?�M�;���D�~D�~t~��F�c�D�
X(��e�L���C -%aq�ŭ|R�(O�{�R�j^VQp�c���rn���!M���^B�|�CsvDT"'��غ�\�F��N�u�lrM�M������r!l�c{�����q���ӮƗ&�0p(�._��>Mn[r��&��GTJjXS�tnd�*�(�XJ#8d�C�U hj������w�
s,��+��󬅯�����J_�I��̥�_�?������ft �]C��N;���$/��b/�F�L��~��	*]KG.Y�S-�0씋��pw�0L�r/`�Tb��r ���{B�p���<ή�Ilh1:x~7��W_�8Z{���Pd��>�Z ��&:S�*�D���NN�8�����j��˨
�(��E%�k)���g��p�|�}��g�&,�������u�U���I����\.�~M��O�8�!�E��9M��gQC:V�d
��ˬb�\`K*�jԂ>�`�]������td��_�6Ӂ7]��W�c�O�r��[)�W�܎�����GH��k�0L�\��r�7����R nf��5��(J$8���:�e�]R�����f��`-���y�������nһ�pW���OӁ�̥��*O${O�j��L,��/"��4�&!���EEb���������5�?�n��ժ_W�}Z��u���%{��a"�EÉ�в��Aako��l�;@��Nf�'�	�@.}&�*��%IE����b�D|n�$��N>�Z���Y;	����-�V�0�\Z�riB�)���Id3s|���XL�4ꎤebf跨*/��E��ŝ��m9V�ny?o
���tI��lto�K���O3��vȚ)��qX�+���U��]J%zAR�(���H�3}��ߧ?*��)�[����1{E��\�o���Ϡ �T��t��������N��g��� ��t�@ܼ�m�3Y��s!;����F�W���>����2ި3���{�z'��A��z����qF�.�{;�gf��#���ɴ�c�EqizN��<S˂�L�aTJ�_\U�.AUYP˪��Fj����0���l��F�Y�E�Y��?]Ҥ�
<�
Í�x#儿�z�c�zDdeҲ;��E+���VyC??􋊦-�ˢ�b.V;;����~��v�%��J-4d�qZ~��tf�b�a�8u�Hm,"���L&f���#]������~w3��.�*P�d��據3{���ڠ<���X'�N:<֟vZ�4�s������8�c��)b#ŵ����ڄ��q���w���GZJ�¶��R/4z°_>����^*:�����v>�H&��D5��{�xb	��$� 3�6�Œؒ`]r/���7��gz2�E��G��!�G��̹󭖏ްoE�ȡ���� s��E��[CiK����I�τحR�A��H&=�XO�����"/���k�˫��^�O�i'1�ղQ���n����s�鼄�٣M�zQI����h�Pd�R���3�v
���83����1�G���j&��<`hTQ�H=���O�h��م�\�ۇa�x	R����.�%0�.I�N�"��&�kL�nJ��̾="�T��P/�4q�AzǊ���<�a�߯��7U�.�TY,�={4�.��:��,��=#�܊�p�)Qc�Dv#�vOX�1���d=B�u�~�#�ia:Y�Kǔ<�G���mx�W����,����r%����c�FD�%/�c�5�����RHd���(R�".m���#�{�����s�Q����p�ܶ�>��Pu���-�F��w��0��,F����GKdX"����{�SP�K��V�j<B�,d?�u)��,L=bj���)�d�Ծ���T$��m����{�4OF�bF#�h��F�;�L�<�-�]� r-(�	i� a-(,.e�����蝷3�}����^a���v�_)Ssz3L>�!feP�S�RT�5�ab #!W�K��q��.�g���#u���1�)�^��ω�����lk��O�������u�ڃn������|�8��iQ�_�{u��0 ccl���.�ݱu��g�;t��T��ѐO�)"yg��"���`f[M�7B��w&v��<�Y�]o&ҙ�������W��H��F���he�:������ �N�s������H��V���j�
���7nT�'�Ysx��ē$q'Ffe����g&��Eԯ+�����������+J_���Pj`i}�a5|ʸ�f�n�D3ɽ�	KX��A�ݩ����zhjS*h�?[��c�ExUY���a��}���p7��z6��x ��0��^��j�i6��B�a&�Cd��̖k��:Oz�Y��0�:[	�r�ߝ�� ,9e����;	��^<9pn�Z��j�nb�����S,��`KڄS�k��l��G𑛝������!u������w�����#��Yx�X�j-/xce���&|�I������u�o��N���v`�4�נD�#�F���J��'��>h�	I�1�Ė����K�k-���ʋ�RU`�.ٴ��'���#�]��e��C7{�<>��B�
�a�Sf�!&m���'p��]���;l�YTU4�����n��9���"��̼���;�_o���U�v׺C*^d�TӲg�O�,h�{PqN�@M�̈.3dU�.utDm��bY2�(����O�~�>)_�Kؔ���vM��]�;�@� m�&݌�>��C�{�QE&{C&Xr BēqeqO�*���Gk��cK"����C�u��L���~w�c�{]*7ox,��iΟ���m�L-���D�[��8� ���#�[ʻ���#h��#���O-3~�����]��x�ǋw��1�4�j��c�fM�2�.����M6B��	��,����&�9����[�\�=�	dr���]��S��o]uie�P���l��j��:9����y=+��.�T���dIbOb5�p����z!qi�3��D�Dׇ�z$h�F�y�n��5.Y������'Qq#��41_Xo`������{��X���s�F>1hn��ܘN�գ�7J	3��s�@n�p2UO��w�!~���)��S���G��t�&W�>���g���+�a�t	���̏�bT֒>2��*�1�3��Aa>[LDX�%z���ꏌ;��|�k��]E�G	�)�H[��Y����t:ުO�%u�0��|<oRJ�K�͈m��:$��A�Օ�n�	T�k����ho���/�������_��'�sx��f+��c冾M3�vdĕ�I�T�A��E��!�I6    �n.���Rd��WwfB�ïY���u�e n.�{J�t{��ݦ<I#�����A��O�08AU�>&���' ӈ��r�\y��(@��������)��]ZQZ���WdG���|K���O�k*Q.>ݟ��#�
`M\(S�<�l���N��S	���~�v�<m��]���X�r���Em�[m�����0��W.�ўk��fT�����:�F@c�ѯ���_�9�඾�T��%�k��;´b�:b��-��>��\���ZX��w�M���H�6r7V6I��S����U����y���+h�e:�.��������X� ;7鍘�s��}�5u�E�@�a]\����h��:�WG�.�5m<M�-aB��1�h�^vH%͟�.Om+B2�Ә��wנ�vimQ�F����+O�BG�򄴔���Yy��[L�X�4�Ao�ͫ�Z;�tz��;޷ާ[]�q~�6Ur�9b������@~���Z��1x��=�9��4�ԔE�`R��p���ý��U��s�����}{����e�Ok�$2Q䍙�̠-�^4�Ԅ�T���Q��:˳s�[�\)!������"�+AX���BE76��	�ss��]zM�$5��6�K�?�D�P�:(�h�bh�v�hJ�Z�P�.�H�	��@���m��Gy���ϖ�v�����n�h{\y��)H_6��1�xp�����=(��J!����b]��H��r}"Xr^+2�M6�Ai��_0�%k���#~\Y�^�q���zm�N�A۩4� 폔}ZU�U��<a�X��-Yݍ�d=�Z�woQE��gI����s?ӑi��0���u�����h=T��x�fYQ�t�a���'�Ȕ��M�n;;�M�PT����=5����@x4a���C&�C�,e�Z��z�v�g��AK���~�29[ߣ��:���鼄I}��@řU՚:Z[ߡ���`ĖA{2��c�R�31~���҃"��D��MH��~dn��p��������/��
�����O�cN+(�&���D�q��#6!�U�b�Ζ�Ic��9��h���'Ǌ i�i�4|�.�Tyt-��p%�rVİZ���̟�O/cGĒ2^�
�2�QZ�Щ��3�;�4˫� �K�1�������M�/cgV���.	�7�4U�����ou���ll��VM�k3AUR(�`�K*�L�CS ��C-�զ������/��^[~͒�e���rlN������¶V�M���|4�zu�4���~��R�RF#�����9��D�t�Q���=̯����D;��jadФH��wq������.��k�wT��-�;���I��S���)��J���$v�v��P���r�SJ����#v���eu�ݧ{��S,��1��+i@�������?-<�T��;@�����<.o�ԸBaj��{�`⻠�^dXNh��ۛ�?�������UwY-5bm�\�㚅��z�뽏.�9[ϼA���0������WV�8bď�c9D��@`/P�:�i�E�������Wa�bi���|$�X:�I�H�m��k�d;�\�+Z��G�`T��(��"�D
bk>&W�l�@����N�I��5�]�����[i)�ĥ#��򾵪���:4�
g_�a�����F�����ֻh�o��F԰ �i��z3��qG��"[���&���ߕ}�a2�.u!:��M��<�8&��sF��������'��wq?��n]1ɺ$��OE��P�ٓ �ff+k��;�ֽ�r��-X4;��Ϻ��������:���6�%Gҫ,��m_���r���XC�������d��l�"��vV���eE#�]��z���ZY���?7[��]����.o����꒢����^�e��7���ݐF�3��7��CT�q�1ih�b 2:S����Z;�Jݎ�rG�U�??ڃ8pݜ|�<����t.����)�֞m��#3���0[�V|�۽"�<�]�aE���o����ȴ�
��E�?�)��l�$��n�f��6I�����j�M�7׽m�%It}��_g3�
��C� Y&�\�pJ��?��2J�������;�f!��B��M��ۋ�.�����L�����SY,����|�;����r��ݘ�8�B*=MMkb"w<�,�*W��u�A��1��/6(�$,^�)Z���9�@/͛�K��ɴ<Ú�q��[��t��7r�Cܣ��ȵ�H��1i-K���D0߇�������o_l���sӨ�����:�*T���{��Z)oj���Uv�3��vh���FIMqK��`�Ąb&��L�	���nfȝ��H����El���s�m󲿖���g�skM�62!��w|p�OǛ�i�I�޸Nڌ7��M�c�1�\J��V����C҈��fdnC5�a{[�LV�@�ܪ
����v[<מ�����Y��pb���S�(��Ӌ���dL�u=z.!�)Qݿ� ���6�����_�f>=n��ʏן�|ɟ�C�2�:H��>.P� �w��6h��I��̐�H�r��7d1'��<G�C�w���0r�B@R��C��ܗ������l_���ۆfj ��UBb������[�IO+*a����E�&\��%kS��Įq�n�a���M�w�|����ܞϵ_�O��������f| 4�V��P&�Tv��ѷbW&�8�Թa).,�v�Z�nJ�Փ��h��!��q`��f��b�,��-*:��[@tG�aЏ˞F�,M ܚ���YE�H�������2��l:���2���1]7�R۩�:��f]^�&���-�s�yܡ�n��P B1�QV�X5��Ij��r��=�[��b�.��o�+s|�vz���B�۳��l��p[_>�V
�L�3�CP�a�$��;歋HE�ILi�n�p�����ߏ-�ylgHv����w��)�����nKϳw��Վ3J���Z*T����=kJ;rf��ū	n��	���2t��4�����˘? E^-N)`ڹ~�d�z�x�����%o��9���>}��w��JaЙ���H�9�O8�b���ͼ 1RЄ���&�{��D��w���n
�8؀l�:\ED�6�;���H��i��ՠ�"ùrx/l� �=Y_�a>��N�M(!�HQM���C 0�l+�*..�Ε�����E��ǵ�/C)���`��}��e�i&�/�'X�ChkAQ�^T�c'rP�RP��������2���/W˛�=F�켳�*�"�xF9%� #\i��+�a�>=�G�
+"{��"v���ERs�9��q`f�_�7C��n��=��`��cq{w֝ e=���+�>1vOp*�k+��d[�72��>���0��M	�@�������Bb��j�s��݅�o���%��Z$M
�ڦ=���O+��P��^T�½�ކ�4:���t��A�"w{ͮ�`ncѷ,"�%�}PӺ����X�L���?[��z1Qz�ի�&7���+",ֆ���l샪�V�,Z�	eK*丛��ᡚ�)b)�6�DG�	��`��TQk5�/o�-Em�'�M��\\Lsjvծ���[K=����׬2	�t���s���.�t'��T�8�%�u�X�V�PJ�393����~fl��iX[�x��i5Iv���`��3p���ga�� �����Af���1�Uq=I#b{��������eM(q����d���m��*|+kA[�Em��X9�ld��mi�K3	pgy�s'C4�?W���!���ͧ��a �l�I�$�א_7E�u��zy�����:�Oĕ/�W/�����ִVO�٭�uo{��n#>����^JA��ǣ�R <`������0e�B�4I�Eԕ�I��e����Z�f�	��m,q:��Qh֦�NW��Uv�o�~�:��jY��$���@K,�u�v�pn�Y��:��	[z�U��\��&u�J;=�����*�����I=3ુ�-K� �֑��(�ҍ ���B�<(hB������M$b$��tH0��}	�'�(/�\^��Y5w� �
O��    ���\�Ok9��2�r=b�����A�:;�9p�����+}7G�y�L^T���a�(�y=�!���#�i����D��"^�ny���*d�f)j	"�t<Q�����&j�T�!#�F��B~�#SB�YM�m��A�߫\�Z)=���i��B����4"��ئ1x#�o��B�[*u�!��%7��L򀭫g����;W�����%������-��y�^����QW�?1����R�]s��׼L}@���E���@jQm'5� �y/�w3�?�D�w�;�0J�Z���S^� 7�&�������B���D�Z�sv6�I�.#���pR��E�A�^�ٰ"-���}��Ⱦ:�ox�ћ�-<�å���Y�FN{�w�nu_NbH�3}hX6Y�("�'�Kj�b�@�����8���b�%@�Gq'�UT����d����җ��PF���ߛrrm&�W'�p>m)k�E�*�̤���V	Cħȁ��3���*��
�TΛ1�~��������^d��>8Au^���>��ъ�k%x-����ٜ�E-S<�D�y��S�<0�zL������(��=�� ��?Э���LT�E�z���$�<�cz��vM��M�J.Y�b'�n?}�3�lBx������e�1��4Ȉ��4֑��J[6�
v�|��@�m�`�(���x>ثl�߮w,�!��Rط���i78��ӓ�)�j:�$YG,0���檤�+ 	X�H�-��/�03 d�� ��sd�E��6a�3���!��r��|�uO���������5��A�-i�c*3�5��wѲ�eeG�rW4bO$w�d$��6�L[t�S�w�U%�.�s��+��9���)��=�t�����;��QC_�m%�S"�2�I�7����őe!0q�}Bk��/���z���kpL�ބ������9Է6�va��C���@ԮM*���;F�
	�7�4���3,�FM�Ջ�~�#[���J"Åj� [�Z~�U���uw�D*��*b�%ȟ�Yº㬲hdB�h�0ĬN�R�*�"S�Ʊ�L����x�mw
D���4����&	��u�gzށ)0�yy.�U$i4��g�:�?�c�ǁ�V:s��L�k�� ��N
O�m(Rs�0�A���Y���$̖�����Py��q�`n���m e������UڟvdP�1l�k�����'T�Id�1�"P�.C�B���=ׇ�����$a�8]�绻��v{5G|=y���������De�\�٧�($��U{f����z����ti4$ɘ�D�%~A�Y���n�������o�J-/�Gz��*�˴��/q����,����ޟ�)	�����W9	[.�5}{�e�֥Q��ȱ�Q�a�2�{���Y��,��e�
�8Y��'}�E_E�<d�c�8�V��!~���T��|ȅ/MK
��)�+T3��6��e��nq��W���Z��..</���c���u���S�%���u�w��I�է'hR��9�آ�b(����*N �F�]��lr���N��<��բp�ǹ}o���C����uy�7{�<����Co)������%���&�F1E�T� r�Y#�E���k H�n�����ek?Պ��z�[u�s.i��ҋ�����s�rpKw��fN���0q�̴`�DwrAӳF=D�D���Am��?�[�"�s�����(K�9뒬�Q65lk���6Ƥ����X����߫��������6��;l��	6�����&/�A����nXH�&��_�v�I;Ϩ>��{���c��� �FD��~ԙ�Y�� 7-?�ϊg$�W�{��+kF���,G����K|�F��Sʦ�]���3�K՟?�L��n�i,t�i�P�l�Q0B�L3d
a�ߩX�*�XE��k[�rÊ���wU1~��S��n�i�����L:^U�\��U80�4nb����U�vt�Ձ�����~�C�Nuy`��C�Y=���Z�1	����4+REyQ?�Ghh����\�@d�}�N�8v�^��ç����}�!w�9��y$��閞����|,��P�bj�c&��� ��dI�L�l~6aT�m՜���HM%6x=]�km.�u#��ǭ�vM�qJ��"�A���/O�%V���~��䡤rR��/�RUe� �W!:M�a0��8�}L��ll�������VQi�^bA!߼Q3ێC@Tw	,�>Eɜ���f���ɐ���xmy�5�t�2u��l8v,�V��C:��O����2�*�O�=D��䵛��NH �\�HL
9���l��m��<+��bHۢ���]OB��8u���i���_�O�Qq3�� cj�>4��E�c�fD����b.P��� A�g���M��TUv����T'�{�����i�eU��E���w��$+�^͕:ųU�b�ϑ�g2�Ӻ�2�YQ�а�`���4��}jA���X���gD����'�z��+��n(�MP���v�5{���
:"LDxb	��@��A)j:+3a��p���2D*��ֳ���C~��x�ioɼ�e��T�C(�k��`�]=����ۋ᫟&��aE��!A��}�`��b�I��zL��[�^��^�o{U]k��!ʶ� ��ו#��D��?��t�L�]�v�w�i�t8�1y�E$��cR�z_΍��L��^Ӫ�e1s�B�Z~_X��Z�6ǢU,[kͮ�����W�12��ܬ��=^vm?���+d�)��#��kҜ'и�7YOj2X�@�DN7B��W����2*��ߏ6C$.�k�V��ٜ%��T\6�;D�[�໤	���%�(&F�V�veqw��ӓBS|Q�VCڂ�YpBuw��H����H|e�zmu%ɋ`i��e&_�)�U|�'�z;����>iGzg�z�?-q���3HL���)Ae���D֔�kU����<AUK�=��o�����������bS�+륰�d ,��j�'��Ew映�o�X��u
���}�1�d�E�l�-{$�U��&UTCI��DR{|~��\�3���r�^���[y�=���Z
���e��K���Rj����O/46,B����42UT�4m���g 	2����A���� G,�G�7)�~��ڹ�����%	[o�^�<�\G]���:�C�?}+�ﰑaz'��ȯ�ĥ��1���݃x3��-�����:�.u��o%,���ݝwzd�p�I����\�R��eV\Z'���\P-YS^�G��ɛ�4���9��N,J[��KvC6/��E��������W�-(rF��e��=d�ސ6�$��J�����iqɯ�\(�������wqh���R�60�|HD1������!�ur?�zԅ׳R=P������g%��$�Vܼڊm���姡b�[SN��ҏ	����P�CJܒʦa�	A	�1Os���o���i�����~���V������5��v��]�}�U�iQ���!��%Bd����`Ł���
����,'��Dv)���C��j��b��[���L��^���݋��N�����|Z�"���% �.���m��%G`L�����&�l��������%A�a�Z/��^����=��br};�U�8�}����s��Nl�}�^W�7���6�� Ztm���~m�lIK�̘�[P�r#5s�n'�$q�a�����[?6���:8k���fԠ��^:U^F�i���֢�t,�s*j�bf�ˢ������H��"�Ne��"�ߗ���N�LAm�gY
�g�(�c���}?����w���˩-L}���?P�"����02�+=�nh���i����E��B�_����/�����2#�-�~D����`��"pG�����F6�fw�M���VY����aRbX�ojJ�\=����w\��wթ~�SS��\q�P8\v)#C���u騷۞/�,[�"�Gu�Zb�έ�` R)j�%35/��kKJ����qwmI�ǿI��L%iu�,'��i��.@�X�l.c��#���J9�>���g1k�MU��e�\��r�?��Z�9��p}�$��w    =?�����-Y�D�QQ���ް���纎��:����Ӗ3h��53æ�R�ɠ��ĺ���M̙h����mvmH�h�R�EW[�{�+:h{���k��{�>�~ɟw����z�F�rSD	�Fx�H��@�Pr/�a%Ez��P�� �[Z��M�(ȋ��3	%s�B��[�6�s��7b>�u�'G���&^�8��"aT �cX�׈����qS�ڍ�4��x�;~W���Y�")��(_��wJ�Q�ߢS�2��?�xM�X���)F��+�'b�Ea�C`�S�C���6�ˌj��ۤ_�	�>���0���^q��b�;�ͳ�j�xe�x%ou/F�����#*�h�t�`�;�@a%��;#��N��j��@��$[Q��n0Ԋ�sP��Ao�5tϼKV2r��~��H3��vr,�|B;P=l*
��U|��S,&�bM���k�+��7)����٫oy)����y�����J!$��$�����O+£��r�i˽ w]nժ�Z.# *jU	���)܁�<��Z�^P������
�����;�c��V���5%Yw/==����hz����I[k��d-�ЧT���+�)huJ'�)T�9ro"���0��S�Ÿv��~�띙�(^��|��N���������ӗ�x���rg+
r۵AEw�ф<S*���a�1��D[y�?0���`�F^E��n�t��p�;ak�b�\��j �^?�2�a���u����"=��=����X�Z�U�w@���˖/�97Rp2ez4��v/y���0yI�0��n��mN��ӹQ ra[�T$;,^E���D�Sfmg�}�5�f��woU��V�
��]`Y�1~U�v�u�4f�x�Y:
��?�����.QF�I&��Y֭0HOn$bG
����|����!�v�������ټm�a�Y�iי�=��h��Z5���㯻.~z�>j�K�5�D� �z$U�V^� ��0�0���+3�6��8���"UPRI�ǻh��P���Fߢs���*S!3�N����ӳ۵�<���ȫX��z�Q�����uy��f	%t(x�6����L���/����Y/l��Z�J�b�fj���Ev^���*�_���M�?>=ქa�Cf���>����2����.�:��c�����G�n�߽����KU�~�t��\n�ז餉��2��.�����Z�&����fGhj������j�I֖Id�Iw�/��'l�aUH#K���M���r�ڳ���Y�"��cy��1��DzYڝx���e���W1�L%0l���n"Z�d��e��r��(�¼��5�wDe᜷�F|��l�������k|H���=��vP����O��)�hB��ˮD�&��=���U��!��E@�M~��?wr{�89u1��$�ޟ����C���?�{G:=�[��}$�|�t锃��$$��V�M�4f*6-O�#\D�wA�!2�$�,������\��h��-�3�U��-��yJ�m��+GwxC5>un~��M9i<��������`r[,Z[��j0aW�"���S�������i�\��eh"N��Z&:�_�UY�.��_�0#|����lb#TJ��q��ĥJ��4��xQoX
r��8���Y/"�J�[w�֬��D���c����Q�Q
)��P(r����o'�D�p����ݏ�#֚�0�Ff���v��L�E韕�69ѝ׬������-�v�8F,XO�6�)F��7J���[͓�;o��'���4p����s󲟘�V3��g`s���M�da�n��3̌���U����p��`Y��;,��k�X�;��a1����I5�)�觫[?/�V3�(�y�X�DC���dQ6� $ل���6q�]!I�g-`��v8�,�71:���ؽ����Y�L1�{��'�/Á?�4U��y�������F�n˛�����rwC5�}��F���oOR�tQ�T��=�H�f}�5}�ZK���3���Bۀ�F�]�7����g�5Z_�D]��,m�����Yj�ηw'������p��ʅ�mzI0�d�xG���htKf�8��V�%�����3��ڧ1n���<��F�$E������փ���>����1lS�%�@˷�&ny�,���.�lWᎋ�����W�Kػ�,f�a��jp��_&������z�3u���a����~��%da)�tt}l��3��LDA�y�շ��LAU��:t��|�9���m���w���ۉ�ts�j7�Gq����;98�l�m��R�G]�V2%�{�
�)�����L�<fOl��H��[d��|�����R�{��&��3�/��T��U���bN�%��%���4"��z�}�,Tfu��tU�az�ؖ7��R��N��J}�)�E5r���o�&�lvs�����P����b�b��b!���v��U�	!���Me�Hdi�,�q#� ��&��@�k�j�mQyz�3�Sqe��{}�P�F��cf�x�a��׮�]�T������<��Z�/k������\ۚ�L<��U}"o<)Si*��?ܝ~>�j!_W��U��}����mo����[wy�X�r��f~;�ٿ.?���'���`��˨B25x�	E�o�7��KF�9]�%d{�h������X�E����vQ�Υ��|ڧ��;����|�m+�)*BaA)�0h���bm��:��4n���0��]O}W�-���'xV��e��������e����gw�xn���y-v
��~q�@X�?�4To(*��cP	�����w��*�J�K�	�\�fk^�k{���H��Q����E��j���{����K���	�_CZ3.�C@��hP��M�0&�D����&c\��ꅫ^�����(ҔY�(+�Ǯ
�Ff��˫��������H�Yg��o[X�2� .lh�*c5�V���;*aGꄸz�	�τ�2a+��}L�gQ4��!�1�ʨY�V���R2�Ԛ��^j�p�0/n�0�v�Kr��[�*,I�Q�
FC�P��^=`�ݐ;�	�!��?����r�8lm5�ko�.^�Ԭa����вϠ�z+�4|]ك�8hP��&��p�?��A�,�X�j���Ɉ;Q�|��S�H�f��:����o�d��}%NT���������=��>h#$1�>��:5Id�
Ȍ��>�y^�9j�jZÎ3y�l2z��xF�˳�|�S�_9Vٜ�W��E�D�h)�H�}����ft�$߂�AK1��8%aI��(ŋ�yUD��|"Y�'��׸�O0)��	7x�e���7r�6WSe�攛0ܬY�:_���tTa��� )xzىuz�^����y�U��.������Ӈ��<+�\k$��X�����2�x�D��Y��l��<���#?�:���[cH��B��t5L�b�7fK�w�"V����7XW��D)2y	.�e]F�Z�(H>��F��=��W�n���:5c�KY����]؂�,�d7`�+m��X+I��M>E�E��?��׊�?�2�����A͓V1֏@=��vi�]~�1�����E0r[���������'r���ާR���
�I��j8���XBa�?�-�Y��"��Kz���mJsy6��u� �O���o�qixA�����M��M�FA�	���Z�d������"�y���?4�ߏ�	��~ݣՠ�rO�Y����(�bnfc����n���$T,Ӟ(�'��x���4��)�껌 Q�qick�Rv��q���/�~��u��g[w������B*�'�Z�n����=j4X_�w���� s��hC�<%7�x�).�Ȭ<g���Ej�YI#� =��2��D������A1K��/;&�vs�!��F�v�{���K2��ۦ�vKQ	� x����1ت�W7�.�(*if�W0���>�(�/!B�ߓ��Y��/RAa��>�@s��4k!/9�4+~�٠��rʔ�^�lP!@��b��\�`^�V\-�l*g=��>..��?'�?1�������0ȻG`����Я�T~r=�e    ���;Ḏ����D�0��5n�8��J�趧���%�no"��W�L�s���R���#eV�
E]�_��ula�������d��'��P}�G�۶K�&�
ƨ^+�1�P���\q�ZZ*A+.�+6�T��W���"�7D�:�=�#	op�˜��M��vrjCp�*HRgC�m��0㒾����Xb��*i)MexØo�7�u+���q[럯x��(Rg�]lw��Eb�Z��ݐ;��:6[i�f�Ќ�o������Y1B�u����E�ᑺ�U��L��D6Ը��+j#m������p��K�����̲��}D[:D|{Q��;)�������a���oj�^�B�D�V�;ô�	?�'���]�guq9�����$�ް��bN��d�ゐ�*�����d/� ���M��mIà�)
�����$�Ɔ�ԁ8x�R/���7�|vn����Sz%�Ѳ|��,p�vzK�s9��oKKB���Dv��\P�����X��؅��[t�[���%���O�:��y�B_̔U�l��x��i����o�ƈ�C�<<7���ߖ�`"S��O���_b
m\������1�Qj�*u�<,i� 1��?<���L��q�%�6��v�&�5ӕd����H��#CgY�^�j���"L���5��t%#}��NmA<�'IS����2�����/��n��-���w�1|��4C�t��kR ��X}�p'��s�y��d0-Rj�CG �ңp
�t]P67��է��B���/S��\�YÜ�5���{	�\r�w�n���ͫ���
��nXI	��t7�<�a3��HwܤУ�ڢ�TPbo��iqտ�S>gr��lO��[��b���ӽ���fƪڿ�P���T�gԽ�7?<-�e�����ɓB )����eq&R?*�x�
�v}�%א�Z�g��-h�y����p��?�l���������ʰL�?�C���	�,�5���%k��F�1<���s,�!-|��_(�\��~H]�9n�qa|���獟�@�[�|��3m�ˋ�|۫�$������fa.�X߇�v�E�v%T��75��J�#��Ϋ��g��8��[dH�����s��O����}K���u+/�t/�������׋��>��ٷ���jp��aa_�_Ff���
RAHS��ѕ���lҏ��'�E�����X�7_����y�����X��K�5O��M�5�ow��J���f<1���ȽK�p	V�5��J�&�e
��3>�[�iln1�X��v�6�R�U7.�H��\wCo�v�9η��u�A�.�P�Fjeoj��D��yY��֪g�2��j^m��%����Y� �<�e�?z����{{�m��?�YmEG�<��o�M��uQe%���AY�16zV��)����R���4���#�s&��\����Ip�ٕ�`�������/&n�;�?�����0X��^A�2��fؤ���������b���[��(z������H��-��9M��-����a(A�&�c�}4���R�c�2��khD�<�v6�TxHLއ%S�.q����`k�*��톤�2aۑ�������!����7xl/櫙���>�uU�_�ǧ�i.�����x��m(Éd&m&�np[�@Z���};�xS)Ik8�Þ�6!�>�j�~_�f��7��y�z��ܻ}�9�]z��v�����{����;�Q���#���פ�Y@���;�2=��D~Ye���1�>��~�[��f{io���o9����ۢ�N��u�ݢy�G�ۋ��M"�.�5E����g��huRi$ܰ4
���;21�Q�?\X�-ln��M���Z4���\ַ��q��/���.d���y��wh��t#���g�\I��G�f
y�J�'��ȰS,j�v	��;�KI��)��E��'b��e����g�������N���&�V1�!�16k	 H.�`���HZȒz"�c='��6��K<��mj���܏q*�z��k�D��>؇�Kv �ٷ�I#h-�
?o�yZ�.S�ַ�!��gV�����j��
�E�z|*��	^�Ki>s�����1�Q��'��KXV��h�7��i�=I��o'��\t��{O�t��&2-)�T����������e���|��>��Y塞���;��ޣ���Gn�tr>/.w*�v;uk�q��ޛ'Z�VϜu[A�� ��J��53�K&w����� ��d@���KY�u���*���Wf���:k����Oi.��ԇA�����Y2�
`�����'�<���;m��' �d+Ӧ 1�<k������|�g�/em�/6s���̹'����Hxp�Z����f��*ɷ�i�\\�<�d��U�ʬ�e��j&��'�J MD{�h���z~ޚ�R�g����.�;ˋ�8w�ZK��k��[���1ېط�!eh�n�t�,Hb]Ϥ��O�)�C{�@���A �{��L�p-���/�]�=�BS�H0�!�~g
�I���׺�H��LK��Vj���`w���8"L7�-nf�IK�p_����5+On���r<�S�w�n���Y|�a�c�������v��J�e�p��IMK�*t���d����۬�;Ҽ��窞�J3�ٶ�웭�q�&[�D�GW4f8O��=�Ӆ��ۚ�Q7�P�J���l�IO�J�@�c��I�`�GߡEN��U�7�7{���J�ߠGX���dG�P֜�S�{m�p#������ʆ�J���7�r��T�%�D�q�έ�*���!�Г�WZ���B��A�>?����$�,f�� ~�Hv�W�ξ��h�Wm��[���ˋ��ow���&hS�����n�V�K�[E4b�qNU����^-��t�&9e9���@��kΡ���O���2?^ͧW��K��ߦ
j�'cub�S�ѬԐ��k�#ih�,H�Y��o���8o�����:$i��U��q���u|�֦�W�?F6`�&0^�>�����S��7d��5��0���Y�\�,�A&U�@Y��7�S��۠��Ķ�>���W��y��*mM�p�v�����t��L��@��ۭ�XO�];���*n��'�S���>����8P{�<a(I+��%w�'��Y���wۋKNMt-�m$���0��jOH�^�o/�P���l���ZiǬ�|,e�����ƚaz2�9m�%�^���?+�i5�eA����K�Z���5jBi��ʋl�N���~{z��J$����M	x�j�ǿ7OEwVR��mR�'�*r����E�f���z��\9���8^�ZM��Q�	|�F�X�ڷ�q��L�5�2����k��5��b�z��j	mbM����c��K�"��ۥ<ʬ?���v4U������=�auHn'	t}msk+��%*�\=�`�T� I�VO�`$#=s��m��1��KP������������M��=6��Eog��o6�1H�Q~����<U�vV��|����#6������#b��w�W@a��5�J~��:�I���ҟAڬ>d�>-�3XPy7��d�#O:���O2�����ɦ��L\ES��"�:�8�,<^�'���*��+����>r���߷U��Y�J׺���v}<�G��lՋ�A�X�������vf����Vɬ��15�Ƅ(-�5pX���g¸G��k��u���j�N	�7�6_=�PU;����L���%t*$������o��&S6\Ed؞l�(pVA��s��E)ZL�g�xZP�ԉ�����C��Y̎�����{�k�҉����V��pI�������mqo6No�%��q{Q#��V��7+�J�;���O!��d\<i�|�.�3��*/g�2HO�'�
O��A����aVtn��5��������XﲺK`U(�&J�ȷ���ĩ���KnR=�a�%�M�n�iy�i����Y��N���c'�/mp�������?��F:����6$��u��7�/*�����8�
��b���Q!�M��f���p�?�c���l�:7�z�6���ХV�$�{p�!X�1q�I�m*�ٴk��D'#    I�9���"L�����0���`�j��@�C���,ܴUv�7p����F�U����E���(r��U��@]�ɾ-���2���l�����	�"�(#R�|���âh��VW����^�ow��R쯝�-�v��׆�o�*���|�G�:�a��MX"F�9���lȬ�	���s\Y`����o�m���J�~u��@��eD�)(/�������o����V?��Ry��J,3db�g�P�LJO0�sNej�}*S�����K�_����C�{�8d Gq�Թ�)�'ɵro�Ad���5-�N��ZBfma��RASoK�c*BXs���� >���ĶTgOU�_R�Zy����jM�y�>x�8�l�������=Pj�:c�,,��. t;&&�=
=Ϧ�F#�%P�=Xj3{�K�3�Y��W-M�h�w^[Ϥ5���$�}[��*��Y���z��/F�sa�B��V}����	R��R�p�˅��0�
�Q��~�jnK��3��c��v�	,֔�ۮ���H1��k^��.�\�P�FX�N����d��yD���XN��G�6��u��;v �9��:���+�I�ټ�^�o�J�+�:�<�-��)^��`��T�!����Tl(s5ج��;Z�(i�BӥY�8Wsu/*�o���=������qQ il�6��=��ޖa"�E,sҚ%DQ��X9ID�ނ�d
kh��Z��W�'9}1�º��}`��_�4x�W\�����%Ga5Ac|��)Tʱ�|��7lÆ+�1�������j��ݰm;�����˙Yo�t�[��p�g�դq����\�=Y��C��߶�ٯ�S}��y#z�*i/��
O��5TOz\��Vr�O+��ڃ߰�5�����%^���u�l�|S�0���9��gE�����-f�7'�:���� y�إ��cɨ6h�fu�}&w	j��p�?Em�~Д����O��k�:�N���7ei;�W~;� �B\�ӷ�M���)�&fGTj
Ι�����XAϜ�����{r�ͥ��G�_Ǖ��z�]qJ�+�
�C&sD�
��-W���
��v��ݷ�Oِ$24E� =�+I
[:@�M���e밿�p?A"�V��tGp�S����Ƿ~���c�ַǫv�"���}�ӫ���)R�zD��QtyMώD,�ΜB
���`%�\�<H�+3�[n�ս��g=�^�Z��	`�V���п�[���o�ʭ�S������l��I���0}<��O�-��$�@C�I��:�ǂ��:Kױm�nw�?����u5ӷ��W�z���{�"̿=b��[�J���#G�A��$" ��M��	Bl�#�
�~��k���D�w�3N(_d�]�R˛�� ����9:��ֿ�j�h�a�&&P�[* ��.�"a���餱jpr�4|���H7�g�~����2K*��8cۊqvS��)�_q�)�o��jWc���S�E9�`���'�r��8it��(L@�� ���h����,×���_u�g�)e/��͖�;��(`����)��r���������_�"Tf&2��Ũ�Z ��m���c��j>��P~y����D��z���<��f�9��}sv�߾N��h�J�=Ui�"j��ߢRLu��KQ�m��X�Z�2Յ�u�� �'��~=��Y���_��Û�=���I>��0���;���<��l��)|���S.S-m���0'-�\�����*P�ZU���f�%M������C��@B��7�������fG��vg!S��PW`����f�..O��;;��̜��1֦7jGU������i���Fy��9�������� 窰ޫR9ӥ���m�8"�&%T�������C�\a�l�.q�2A�ΦHKU�~��Ck�	�$ߐ��,�ިl�T���Y���]Myi��39�����v�F��oW����O
?U�[��#Ty���qJͧ]����M�^%��6Z�gO����o�L�d�b�Jk�eܜ^g��Hq��fݐoKJ�]�xd<y�j3��~���P�K�r#!˧O	6z�%�NW��Cxb��/�h��Ls4��瞱;\��&^�k���{=^�^�֞&�>�k����F�����M����"�B��Y%|"R��az���Q~<�p�I�A���y}�a �ǣ1����*v(4��ߎ�~$����Ѹd%�BZ�1 VV/H�#i\ۓ�6�P�ǷO��>�|6�"=�i��gy(J��`ٽm{X}�n]��+��,��I��Ma	\��֠=-��%O��]	�������>]*�!0���NG��vK����P�-{��:�1H��o�-zt��z�F�B�Ff%g���$�_�\�E���S�Y�T�炬u�{�G���:��6�S�K���<.^�l��P['P_Or�����&#H�-��(i�nb��	Q�Sm����t=d�'��9~�Q��@$��er�-~��b[��M���B^n��v]�'����]&�5�[Pq�u�D@fMQ��Вf�g�D%�!@6��(���D�!�f����w�>*�cq,�C+Y��1i���=�ki���4�M����F�a㚨��)�B�Y0O�U���=n7��oy/��4{�axG�I���4�)��Gz	�.����������b�f�k��e@�	tD:�gn	���I-�+�,)'��%�|~��R�	&�z?Sݵ��<]^l����E�9�J�uy����x:O�U�sGh�uQ�u���P����J��j#"�IS���x��E�+yV��^�O����L�9P$ۃ��`�����6WW��O�K2���z%��q��
�3��Mo�� md3T,�@�2��SX�!��R'x�KzU��<����5i�:KQ��u(0N����)k� @Y��V�����3��r�����V�!c:�#�Ɂ�?��S��6�?���등��F����)S�:�M� ���:]����!��`��DuF<L) *T�`�`�����j%	����խ�p7h�G�=߯��$��J�l�?���&���� ��-c̉�	5�	�6'%��#d��L�椯�2��W:�0����ڧS�x$�?���{�Un�Q�~���;��V��ui��������y]!0΄v��<�5�܋:	��
��d�^�|��U��L!��ϗS��S�'��g/C�c{W�GI�n�����ys���A�PR���جd��TԦ��p]P���hH ��V<=��q#H���X����?�����ߠUX-g���e:��`����_��X�]j����g������aC#��zzT`fB'�:������.�2}��G�by�I��5Q�_B�ߓ�V�x~+�/��������#o�ø3�v�G+��>u[�8#]���Z4"���p�¸ɤ�!����$n�Hа.�s���/�~G��%i6�q:j���6��R�V��8�57�&�4�&���;h�J(!�X(��1d܃-���ӑԡg.�;o4%���so�꿇I��-0tI�Յ���0y�+B5{W�as��"�����r��v�!�zB0XN��xD|���dx;�%w�徉4D����W��h��0�����9�#m�ܠC\�|^�Rv�P�՚{������xH��%^�6}�f��ꣳ��Q�]P�=s�4n����M]Ҫ���]Vf��iu����1����m�a��x�wwZ<�o���S��t�5���ɝ.�cd�Q-1�%���e�Yw��=�f�A��Yb�g��i8=n�Fi��MD��H��>_����C�����XQq@X�b/��D8�~~O���M. )���%��|>k��Ep�/�.�n�w�}/�7���X���d�����N���"�2��j=U:����������a�^�;���~hM0��6[#|�/˦�^�7������O�}�<F��۪9��bK���ѳWR!O"vy$���$���[�����ߧ}�cH"c�{&���(^.�D�HL�/S[��÷�[O����<��q) A  �6jl�$(��'�2]IJ���~z��G@�\�l7��0lV��jM�ԱVo�.�����"�<���4D�Q�X����g�ۀ�^\����6��EԭLj��29M
8���n�����N
i���t����>{N�G������)QȷMˠY8B(���V�<���H���f50���Zm_��sf	�sB�Cߚ�|�-0�)��},�Ąt���s���ͱ����i 	����������=$��3iT�U v�Xq��#&`�\��Ӣh1CJ��;>��<�����A���j��W��*�E߆��ͳ��S�Lf��Eɚn�)�0s�u���ݍ��剱��gC?5�3���������z�]>N�Z�sv�4;ք�����c��R�j<�4��#�|&^T�ZV������~OպIFc��}�prC_�f�c)��S���v4κэ��T��[��l���I�~[� y
�`I��.�b"������8r;�zG�Vϡ2������|)���ɮכ��Kҗ|�����4�˱x�b���)p+O�UX�Tb�]R�K,��G�X(��ҰD6cU��>�����=_*3��L�c���X=YW{�~�=n�׫�]��-��1ߧ��B*^��4d��>���Ɇ+H�0v	��"l����ϊ�������ׇ��y��:h�K�=���V��o�}�3�6=0�
�(sS���^i���AH�=�\���	L<��ʰ�*P㿄���9U@ٶR%�C3Z�3�%��!V���m���!W�eQ"�>�ƕB�0v5�%idt'T�y�
{J�`Cg�(�z�oz�/�G��t�'{z�؏6�.������~�ٯ�[����.6���ˀaը�S[^��ܾ�F"�[�+�O�E�U�fqK�m�A
��f/�MCԯ��hys��+���~��C�4�jbq�%S�'����B�9(r�A�.�q;*��n˦�/��W1 7:���N��hU�,�$ؼ@���s)�.��o��pCmN.CȨ�L
����`��A��H�4a�(sP�)<|�A���_�%aT�����X��J�
�|-{�������RP��"8���\Ţ��-�U1��Qb���i��S0��7`ɓ�0��۵6������JjK}9���7�S�������+o}!����[�w�n��D`Oz��:g�R�̭��w�	���1���\L?�5��Iͳ�W�M|J"zߌ��4�dSE���=9B,�������TE<������(Vf�Cuf�ȏ�~���P�@(��\
�:��!����j�$��*��2�];Ǧ������Z�V�":����������I�`�	L^�A�d�#��6��q��80\�{����6�fr�l���jݶ#��Kt$�V���᧸E�~-�ooshdj���]�*z��2���M	�^��o��31?k8ô�ҿDS��]��7r:������|���'�O���=��Q�^��F7#���r]gmqΪ��ހ5p	FjS����KϔB��R��'��:�M�֗=._��6�����|�;=~CN�����fcM6�jP=�����  l`�J&���}(�[��a� �O?鴜�g/�nҫ�V燬���p�=;���uq�lq��o�9W�[Sn�+Ux�ƍZ�x`��AU$H������ZH�_sm9_�`B9Xܶ�PƇ����-�֘��2�v���vR��b��5Ҩ�a����P$m�>��E��sɍr;SSRi���&86c]_�y�c�>]��O�|Q���mݍdo9����N���-��!��'-Ŗ7�c�̔�V�Ʒ�G�U��Y�RrR?=����r�o�z����v���P,6s'�yq��~�G~���D�����!��[K]�<��|�nT锤�_aɵ����Ij��Ŋ���(:iYl�E���?�K�U%s9	+�I��^�JdCOIӺ���ȗ̞����)pn�!j*=�{�F�U��z���f�W�7�-届�\���8��ʶg���._��}{p��&�{��D[7��� � e����_���X-$<�A��Ϳ���r)�{X{�P�H+�T96@h�9�ᖹFa��5VŠ���)j��4�.)�ZP
@)7 �;Z���F��"�ͭ��EP0�|��h��Ҍ�"���pzع�x��ب���>�İ:����v�:5��ZKа����_3�Du1a��t�����S5VEv��C4L�L���O;?�^�&�N�bz�yID6w��͆�ͷ�;f=N�r	U]�)�	j^�0��b�*b�y��r&�5��>���S?����=�� Qf��>�C��6�j��+���������\q�U��o�<�^�Qw�����
�@rǅ�2>����F���M��N������G@�Tfa^/��vh����r�0#m=�<�$K�o7slЦ��),.OO~�r���(�� ��o�p;���o�L��X*:g��\�m���s���mi�Pw�cnn-�W鷻�\(`�Ă�T2-h�K,���eb��\�m��6�%��/���N19,�HF'�=���ϕ��F����7�~��o�5-�1���|q[7���	����gF/V8�*���g�w��G���g������D���:z�_�c���1B+ 3�����tߎ�T.�֯�A��q	��QTD�'D���zg��iT\���L���U��I&è,�:f<|?m�]\�9���;��n޲BTFL��#�+``~�u�C������l��=Rt�������|��Iv��>�Ak�;_!�n��j�>GܛUſm3�k0'xCE��77����&x!T�p^oQ�7����B'�P�5Q�\�|��H�ĩ�R�\�1�P��j�����;��$I�����02�x��8��&���|@+h�:,ݗW"�k�������<�>�����:w������s�� �m�>�^ors���h�ҷ!I���2��ue(�VP�-�PO[��7�/BE`��٨��Z����w�]v��):.�jY��gv�N�}(c����.��^��X��	=�܀��>������H� �h|S<����P?�����~�����3�����      �   R  x�e��R�0���a:��N��Z���B�'��fJH��o���>B^��4�eι|s	x~�89�8aIi�>��p���#Ň�=�5��RF!�����cY����hyE�$�{m����Njmkj��i̽�F���{�^j��lL0�A�y��b_%�u�� &���$ٍ�f�gz��&�+سrC��'��T4��Mnh���`9)�#���,�YW����"��Z8��3���{�*��|�t#��7���47��Ѫ<���:���]ib��i+��-�����U,�˵��lOs��XM�4gU֓VÌP��9`r�ͽ��Xj�     