PGDMP  &    )                }           GameHub    16.8    16.8 -    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    222   �I       �          0    16682    usuarios 
   TABLE DATA           m   COPY public.usuarios (dni, usuario, clave, nombre, apellidos, correo, telefono, nivel, tipouser) FROM stdin;
    public          postgres    false    223   C�       �           0    0    categorias_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);
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
A�u�^�%���9gp�t� ��x~m�Y>��! m��!.A�v��h����]�ӵnJ�v%Ҋ��<�)?�2��E�IiS$��H���C��k���H��|�Sb fv/������$���-0��"u��$��T���<ϕRo-�_      �   ?   x�3����+I�K�W.�,I��2�6�2�&\&�N�\���\f�.��%�9\1z\\\ �Kb      �      x��Z�rG�]�"�7�@R��H�RK��$�;�IT%���*��*H��f5;n&B.�y�Ɵ���97���E;&�[PY��y�79�����������Z}h�ܩ�(�J�V:����Z�jjM��p
��ZU-?���eyeCc�u/-Mi�l�
F-�	|Y���e:���5���p���U�n�|�ި�X_j53�BcOZ8�lL]x���͏�]jߘ�*[,�X�ԛ�]Y��H�ͼ����� �l~rG��ds���Jԕ5��/k(S���0����V��,�2�-���	�֬\2D������]�k��B�o��s�.����`끚����������n�{6yY�CZ׻��mZ�������:?~s�V�Q�Fۺ��e=�~��[�CN���������Wy�i�K[��� �Ӯ0<�[s�y��5іv���a��+�o��6���hxt����(��&���dwr����Vzn£�5-L�h�]?,�ل+v���/���~vjB���cCv�sf�_�)"ヹ�%f���W���|Y�[P���<���Gj4�Y���w���#T��C<�Ȓh����$F���D��ʴ��646�q�6�/�|���K&n`�ҋ�u[���Q�)��+�|s�E����Jq��y��dD�Aƶ���s�0+��t^x�^����XW��w�^_6��ec+{�E��e#�Wv����eh��1�l?yz"����N&����C���|�/��Ò����F�g'�Z�e�J*�����3[ϐ��P�fs�0�h,�%���|0"�T$1p�k����!R�y@������A����  ��f1������� �9�����n��P�����`?�+�[AhDF9ޖ�Z��fi�&"Ƃ�Nb�DV�,�(�N�j��.�	D�������4\��@ [l������b�_5��\��� �l��8�1��(j�0����{��}=>DΎ��u�d�|�����٥8|�u�;�q���Dbu�T��O���vu�:����dWmt�$1$J�2ư0�ӗ@��N�Z��_����/ƀX�5�11���� �\���m[�b��\�Ν��]_A��
�>$˭Cı�k�����9�Z4�v�~���c�y�è� H���z�~��8Hǚ[Kɬ����20. ��/����"�����<���9)0����P4EO��a�%l�����-u�E*�H�Q�t�K��ROBD�E"��K���[��+�#@M�P�����uY ��!8��jO�c?1ֲK���i�^�R���S�)kHd$l�Z�����Z�=D>jTB	줗�1�99��[]��u�5�KD	^�Fe,�%`�Ԓ���>A�))-d"@b��)"��cP\4HJ����BV !��5����\k
����)��OR���d�(ێO�_��v�3�X_�W�X��MY���@~o��r�pU�L$]|���Yt/�ݖs*�	KF$me<�.�-FA�R��ZJ��Om��������w��C��$m�6�
p�|,�����6��b�[�%z=��"�$f��[��6�|�jwYnnP�le��p	��f�F���������p��WG�"�-H�G���e�V�:2X�bxV�R�v\�T�����oC?шx-�F��I��Z��Ŵ�P�K$̎�%�|�Z"����[�?�u�Z@]oY�9���$� fK2By�\�`#0��)��O ScIr�e��%�bu��A�@.����$v`q�)�讞�Hh�0{ܑӃDYvǓ��iJ���^��3�hg?�l��d��o�uf�FJ�t����c��_!�VԜB +-~j���ko�[}G.�ߪH�r2D�(:uݛ�8ʐR�O|�	)��9y��v���A2(�!�sbj���88��?�s�#�bI�B�iF4���k(\C���(C �w1`V�$b�����Y��/�"?���3��IV��A9<��G�b���RS����_���}em���>M4>::Dlo?�l배u�w�8��v*82�&�7A;_j�ԉqY�> ��t]�A�.�.Z�˭l,��bi*�s�}n{��0ҥ�
A����@I�����Ld�Hyc{��S�W�w�;~��{Ʋ�A$+�,��W��H�n
�\HF�,t���� @p]�����6>��v'��oo�n%�x��6k�0�{�>n�T�~���=�~�_<���u�`��tZI���驐�e"W}��_�Tױ�s�l���Z�al����ce*jH	�h$@-?=��&�l�9�w�x���a�n�D
V� �����S"��uԱ{a��S[jJ�K���x
؏ fr�+��s��z�F�f#�ƝA�}-HU�K�2�e<q@�*g����
0�c��mn��&�3��R��u�zt��D2^@XaRe ��Ƒ�a�eq���P�Z�A[V���S�6l���SJ�"�\��^ ڐ�l�-�٦����h�8���ebw_��ߍ�w�޼��8E/�<ξa)�j����w�PM �g��n�&'ޓI�/���o~*,YlO���5��Q�f���h�`��$�Y��iR�<���ƙ	�X+_��72U)[���p��
�`�0��q�g�`�"%z��F~� +���rbĴɭ�yJl���Tw��y�j�ŎJU
=ȮX�.m?���\h���" B�{�THS�K�u�(M��Z���
�S��|�$$����Z�i#���' C�����q�ɾ^�&�ϻ�ٓ4/+���s^v���a��=>�y�]��(8�;[�R��+��d�;��Y�'\p�(�+�(�^B���.�ꕩkS�#�G-u�L����yC{�ٻ(�/��g���}\�0�׺�����fg��'ݵI��/n~��.t�;G�o��DL?������D��䛳(���W ;��_�C3D��8Sg����6��LCU�w|h Jtc�#�����l~)�k{y�أ�5����� ��l{z�]��a�'�{GB�`��!�2"j/`�⾰�<m��'&�ƈ��4���l���u������_ѝ�G]E@�L���i��{v�����8�t+9�P�B9~{ �=��J#����7��_�������#�-IX ��bbq�FO���bX�����;��4'�Ʀ0��A��MK�±`��[�(5熰<�Mc�1�`�UH�%�9iM��8��I��~�^�YC��q�2��wG���c@��D�ՓL�;�Qv�M
�I�g�_#=�#�d���aH�9�n#��Kɺ�)#a8E�j����=��hT���:�5ϭh�1�6_>��� 42�I�Fp}����".- *E��5t����@��-;~����+;��.�8+����	�R{�i�oy�tIy�i^�>fW����\�����Oݠ�mSj���w��m�&>�yu���)�O�q^�5BpCG�"]]8�U�vQ�u�y
����&��0�x��%?�����S���i����|�m]b�s;_ g�ξ�r�|�nX\C�r��2�AW�j���#d~� [���n�L b�&jrDy������#����m��O7����'x�20�n���¢[�B�Y� X�/]�l|З��8��f�|�y�T+DmH!w���P'^�ћʙTa��<Y.��;����F�u}����`wo�0w������Ź8u_h�x/{�&��a�`sO(�U�J�u3�	������vMN��K��<P�P�j�&8^R�l�@\�>�I�:�@|�W36�}� ^!�"=��f��'���9cQ:b)�޲��$�(�%��T
|�m�Sɡ+X��H��A#�#�i�m7�����J�^͹K�ml�[�KخI͙Ӥ�����C��0���:N
�V�b� �I�a�v�%!�/�)<'�4i����l�@THPx-m������ͯCT)6t�E�`#��G�[,]���1����q�3J��B!��$T�Ԕ�z�\.U�%����=#4u7���@ӻj.H� �  ��=u�k�����e���՛gI���4٩��/Χ�����m-)�L&\�Y5�܀����抬%�<���p���E �ۓce*�������d��}�,�yX9�V��nDrM9B�z�(&oKHI�Jk�������10o9���H+ar���E��@�-��,_�M�W�����x2֩�ߜ�{�$��� �4	����v�X#�NX亿8'��mn���Z(�4!$���ã� ��5��X �:=�$%�����Ě=����_�/Pļr�/����#鮦T�����n������-�K����� ���R���'�#�ݳ�R��B�\��PB<�i|�>��K�#���
�]�К#/��"K�UgIT�
R�G�ps8��X��vi%Jen�n�«r[�7�y���n���&�"B���I��"����lY{�.nI�*���2v�Gi��a"�����dk*��pgg�� ����      �      x�ܽ˒�ʶ%ؾ��Ӭ�d�D�eC���p���[u GB� $!���$��ǩN�ŭ�K�֊�����9�|wp'�0�wl]�Q;e��f�ZJE>�������o�o���O��G�7�:]8O������ѥe�����!���/��_X*����?���%���$��������gI�����r/N��?���%�:�m?�U��qMȤ�g��*���g\/i�״�ha�jڒ�s)wؘ��
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
r��8���Y/"�J�[w�Ҥ��D��1op�2�@�B��@�;
En��"��e���M<���ާ���6��Z��re�ڕjt2i�V���Dw^��&"��KK������`=��Цa��(�z�n5O"�.���C��y^����~b�[��f�����7�G��5X�e
�03��V����ñ��e��0ﰄOd�ebu�T�2���J�
" 'Հ�(���n��Z͸���b5-].�{�E=�Ђ�d>{�����v�$y����&��>�����8�~b���Cf3���E�H����TQg��������9,o�v{������a��6�}�
����"��IE*0�����Zj��w�q��` ��5R��1��>����R$ꪕ�g1h��}��ݥ��Rsu��;��mm\�`�+�@�T.4n�K��%k�[8Ⅵ�@�[2[��A���?���/�4��E�>�q;U���]7�$)r�0eܝ�d��灄��a��.AZ�]4q�#d��vYf�
w\LTt�$�M���\����e1s�7�U��w�2�-�$��כ����u�e%��۴ -!K���cKt�q�g"
��K���m0f
�r��С������dnDŽKn.p��Nd���T��=r��?�N���igd�o��@�R?�괒))�;W`L?�N�gJ�1�xbS�D��"����s�������c�4A��)}���\^��׷�p�7(�_-��N��-�k��k�2�����"ӹt���!5�BFw��W���cN�,(�������g��f7�(�����]=�.�.��-��۾h�>��a7�.Q�2̱��T�D���7r��ajR�T�&�V������?<W����
Uod�=f�0��fa�ͪޕM����n��� h���I(�i����Y��3/]�'"�Ɠ2���8�������u�Y[U��G�y|��V{m߽u�W���)��nk���k��}�(}Bi+�߹�*$S��ޛP��zs��d����u��l�m������(�x��.J߹��O���w�8?R�o�m�4EE(,(�c0�R�-_R���2"���Ժ뉢��j�%�#��jֿl=�?�?ճl׷���΃ύ|_9��N��`}�/�Tk�LCE�񆲰�"�>��{��l�����4a���?"����l�K|m���)�:j��|��T~A�{z���?t��Z8��kHk�e~b��A<�I�䛨z;�d��TY�p�˟��E�2��e���U�����uy5��2�V)7�,]@�m�TąM�Ce���RxG%��H�W��!��W&l����EL�S���%iU]--%3N��*7��v�o���$�a}��%�$կ`4$a
����S f��S)� 2x��w<L�,g��6�VӼ����Lͪ�9�m-�j��rO�ו=؈�u�jlb�w�#)�T��ʢ�%���:^	������Ǿq?5�ti�(��C���O6Y�W�D�K�[Iy���{�s��6B��ɩS�D6�`�����3��5��v��5�8���&�����gt�<[�;���c��iy��XM4����TۇΪ�Y�mF�H�-(��l�S����R�HK�Wu@D.�'�U}�H�w�	&e64�O&�yOp#��as5U�mN�	��͚up�����M@y���ǐ�X��ꥌ�9n�G]�K�rI��?��{>�g��k�d=�0���?Z��v��ȕ5�t�������{d�Vg���yk���CH������{C���l)�N]�*п���w�OA��!���R\�et�u�Ҁ�snl$��#�zE��v@ߎ �S3F����h�ۅ-��2Kv&�Ҧ���R�H��S]��s?x�x�������}=�h����~�n�K<���������.����4\8���t��>�;�5�>��e�T8O�xD��P���nX��
{���n!��a�\��=?�PVlS�˳���i*�/�~{F�K�R4��^&�<h�=n�7��L�tt�Ђ%�(��=u�>���gр>�&���u�V��w�=9gm����,�����S�%���P�L{� ��.�5�������80��2�,DAǥU��K	�}>���o\A�;n\�y�u�}o��k.��xr���f�k��ۣF��%{�_�0ǉ�6��Sr��G�����:�cq�� �_���4
ҳ�)C��A��yo�_�����cR�j7��Zo�j�n�ǻY�$�!��m�`���A�G�}����Ju�⍢�6`�op�����c���"��=�N���"�M��4��@�r�K�◝�o�L�[�T*+�!�h���em��RΦr�S����I��s��#I�9��o��{vy�l�*J�'�#�P��    �������)I�SYZ�F�C���n{
���Z�*�fQ�&�x{u�>�l���
��w)�
T(��2��c��^טݷ'k?�`��3>�߶]��41U80F�Z��1��p�m��
����R	ZqY_�iH�����ki�!����Ix��_�d�oz^��SB��UA��:�o{(������ň�n��{-TIKi*��|�A�[yM���Z�|��'F�:���`��4(��r�܉Oֱ�ZH�6{�fD|{�(lݐ�L%�
��ج[^wo/���������gj�%���M��6�f�����W�ڿp���,�'�,���A���c@ķU���bюO����S�'~S��*$rϴ���}N�9�8����>��ˡ=F�&	��u�ts꾮 ��Wa6η%�|����l���oK5�MQ�D�%)66����;�z�O_����s������ܴ��+Q����Tg�s��[��a�[Z��%�為�T6^�*��.l�gآC��m�(A`}����-��LYe�؏���^ah�����a�x�1���s��h�m�	&2U��Dz��%���u}��LM��Y�6�RG�Ò	S��ãh���`n�^�h�/�jn"^3]Iv�yیt�<2t���ѯ�_(+��>]#�`�IW2ҷ)Y��ēx�4���.s��_���э�s�E�2��.:��s�fh�.Ԡ\uM
`Q�o�Ė{:O�0�l��EJ�y��UzNA���J��&���4��*Ŀ~�?Lsmfxsj��
��%�səߡ��s7��,"*�o�a%%������Ч#�q�B��>h��SA�	��N��U�J�N����}�=E�o!ۋ�>�O�JF���j��BEswS�Q�����p���3�N$O
�L�C�řPH��������@K�!��*�n�[�����D�a��_�l���������ʰL�?�C���	�,�5���%k��F�1<���s,�!-|��_(�\��~H]�9n�qa|������� �-�n>[����EwV��UC��zppb�0�{���o;s�"a�����VT����p�U��3�L��-2$���������'F�|�ľ%q�Ⱥ�
z����~Jk����E�z\����Eq58H���/�/#3�BI� ��k\�����L� H�6��Q�Ϣ��XGr,e����{��U��R],|�%嚧��ߚ�;�m���Wr3��^�q�ޅ�_8�����j%c�2�����-�46��m�{e;Y�O��*���Y�������n;���T���� wN({#��7�uk"���,P�k�3a�k5��ڿI���x�3�7�lY폞�+n��^�x۹���sV[ё>O���mӆ�r]TYI��}P�e�����{Jl�����55-tx��E������7��{�rv%/��|�n#�����8� ��)���1���G����6���.�#�p��²��m�mm�^fl�D-,<��s��O~A�K�g9sJХI���EM%`�T��E��o����ŷ݂����a	�T�K�h�d"ؚ����G�!i�L�vd-o>5p�_��_����|5�3�g�N��������T5m�e�{�\O��e8��̤����A�nH˷���ogo*%i�`�s�&d�G��v��E�j�z�.�0��ʽ�督ۥ��m���N����p�z'6
�#�~$8���T:�p#�{�Q��ԓ�/���9F����<��l/����m"��{z��z[�!�I���[4o��~{�_��I$ڥ�nQ-d!�):Z�T	7,�B � ��AFLk���+���M����;@�f����C1�7��}��҅��>O�}�t`�n�u�������"�6���L!/V����v�E��.�xg{))�7�]�(�D�z�l5���� �x����I���d�*b� <�f! I�E�szIYRO|��V��sI�O�G��M�7�"ݒ�1C%V��s훨~���q��7��s#i��aV��M1Ok�e
��v<���j2�^��T�hV�O�X?��t)�g� �rr�7�>�U�d�v	��-�&_7�'������N}節��D�%��J�}�<�{b��a�T��1������6�?��{)+3�䎲���h�?��[2��ϋ˝ʯ�N���a�}���I���3g�Va�-�C��ku�L�I�*n�,d$��<���㥬�:w{o��j�+�A�j�5eq�ԧ��S�àK�o��,�d��JY��[��g��6���C��iS��@�������\���ƌ��6���O�j��	l��t
O$<�z�\Z[�Ly���݃�B..]�`2R	��Te�ĲP]5�t�B%�&��[�A��7T=?o�x)�3Wy�W�L��E�P��i�%C۵���f��mH���24^�Y:j$�.�g��ǧՔ����U��?cr�  �Ͻ}~&D��Js�ޗ��.���g�)�`$�Ȑ[�3ݤ���c]�$��I�%G��+5M�R�;L�tM&���73����R^̚���'�Z�J9ܩƻ^�ae�,>հ�1������`�~z%x��p8������:�Md2zJ��m��i^�G��sU�O�
���l[V��V�u��vI�ݣ+3��O���e�mM�Ϩ�X(B%WB[6����R�d б��$�����"'������s���7���r6�6�5g��^�>��a��+����R)�,%�퉻 5Uy	#b\�s�����Ei�8�d㕖d����fи��oSX�S�Ga�x$;܂��wg_�g4�����-G���E�ӷ;L�S��|y�R�l7N+�%ʭ"1��*
EI_�/�C��C�����Os��솃5����ק�z����ӫ���?��oS
�Г�:1�)��hVj�`�ۑ4�d$Y�,X�ط��Sm�7~Vy����Z̪G�T�c�:>UkSU���#0e/E����C���Zl�2���Jz�W�N�,S.J� ��W�,u��ߩ��m�Tb[Ljf����n�j�J[�8��m�+m-�6S�%Ǣ�vk4�ēa�+褊���I�!"�O<=2?gj��'%i��Ȟ�	&e���r=����S]�aIc�;�d��R����(���C [/��V��1k:K��#8&���f��L~N[~	������ϊ"EZ�|EY���| �����'�t��P�{���"[�Sp?�߾=�IQ%�\`���<R���_������;�)��6)���������E�f���z��\9���8^�ZM��Q�	|�F�X�ڷ�q��L�5�2����k��5��b�z��j	mbM�~T˱
�S�H��v��2�飻�M��"�,�u�zX��I]_ۜ����v�J-W1�'�|�-HR�Փ(�H��BD0}�0}�l�T.�~�����8�{zqD�l�M�/B��ٽ�M{�d�_���/O���')�^j�����q��6zD,y�W����
(�Qó�_ɏ�_=I��\U��"H�ՇLڧex*��x�,z�I���]�I��!W�շ5�42^���h
�bQ�UC`�R���K~�dp!�\�5z��{��G��!��J<�Y�Zw��ܮ��u�hA���z�=H+������ۮ������*��9�� ՘��%�� ��Uڀ�[�L��h�a-���V-�)����=�jG���W`���~��N�D��P�����aʆ��ۓ�3�*1ua�V�(E�i��O�:�1��u<��q`�y�|�y�R:Qp���
�.)��5�߾-����l��;n/�b���jU�feQ)~�4V��)Dѓ��'����E~&�V��lX�i��Q����8H�8�z>l����mZ�F�ޝ��4�B6�]Vw	�
��D	��غ�8��~�M�'6��d�I��>-O?����9��b�ԉV<q~��������0�rB���H�0�߆$�����F�E��[z@����9.6i[lR��(i��i���;�*��sc�gh3y� 	]jE�MҸw�����Tߦ�M۰vLt�0��T    ?�c�q�*�tY�	�H�,���7$�?4�M0Q����M[e(�q���qh4Z�k�<_T�n�"�Ye�ԕh�����;[-���ˆ�Y�Q�:��+B�2"�箿?,��lu������vG�.���	���aw!�|m�������ͷx��V�A1݄%raT�]@�ʆ̪�0ھ<ǕF )k��+�`���QY��ԯ�� ���h`4e奴���]����r��G��]*OTZ�eF�LL�A��I���z���L-�Oe���=�|)���_^tqh�bO��(n�:�2E�$�V�-1�l}{�����5��X�BKH¬-��;B�"h�mb�{LEk.��1����ؖ����Kj�Q+v��Z�)�7��cg��T|۞"�ݳ'J-]g,����A��n�Ą�G���T��h������B���^��R�w����UKS>����3i�o��;�nߖ&�
}zV��}�����G�\X���U_d���F��o��?��r�i�,���kT)D�߯�����a��)��v�5�B���"�.RA�Ǻ��k�%W�;����l�b*Y��wC����ZN��G�6��u��;v �9��:���+�I�ټ�^�o�J�+�:�<�-��)^��`��T�!����Tl(s5ج��;Z�(i�BӥY�8Wsu/*�o���=������qQ il�6��}-7�-�D��X�6�5K�>����r��ҽP�����B�Pu��OOr�b��u!�]���:O�4x�W\�����%Ga5Ac|��)Tʱ�|��7lÆ+�\��ta���M5��nX��������˙Yo�t�[��p�g�դq����\�=Y��C��߶�ٯ�S}��y#z�*i/��
O��5TOz\��Vr�O?����7�jM�f���׻��m7/��%�4�vuΥ�Y���3>~{����͉���/�7y-@5v�`�X2���Dc��]��_��DQ��ũ4�"`��S{󚾎��n�y�MYڎ�ߎ ��������I#T�7���JM�9~����+�3��X�s7B.��4����\o�+.CI]ceW�d��\���Ra�X�N���)�D������y%IaK(����X�����$�l��Mww�;�ٸ�n{|�ǋ_>vk}{�j�*���K:��[A	�	�"��G��E��t�H����)�����fP�(����ise�r��ϰ�U����kS�?��Jw��vku�maU��}jАp����=	8P������IO2
4���ܮC��0�`Rg�:�����������f��6��Q/��5z�X����X��֭R�{D��c�-�Ʌ�q:��DF�t����E��oaqsmvP܃���x����KRjys�Du�bu8G'���7R�Q l���!vA 5�E]$�A ��T1�4VNOϝ����L�ovvtXfIet�� gLb[1ή`�9�+�5���rU�jlaVu*�('L�����] C�U'����	�������Y;��e��^���� �7��%c����v����߾�s
/�\�c-gc�%���r����L/r1j<i��6r�b~�X�𣡚��<Ԁ_�û���5����!���oN�tߜ�����2��tOU���>뷨S�d��RTi[��1V���Lu!s�},��	�{9�_�"ii{����f�p&�r��;��b'��F��7���#�7t
:<��TKf� ��IK#�'�@!�
T�V��\]H�ג&c�v_q��P�Y �W�KWL�zx����,d*�p<�
�<[��L���Ivg���S01��tF��
�^Tԟ;����h!ϲ�?' ��� �5�\��\�{U*��2s�4�?��Gdפ�*��wx w���!,���E"N�A&����i�
���~hm4����?�%��m��s2k���)/Ͷy&�~��}��7�HU~����>�I�j�r˕y�
!OP�:Ni����C[>���k��w�F���	�0s�m��lU�Zi͵�����[)N�ެ�mI�����'oVm�����*}�[nd#d���`��\��q��/��~E[,g����~8����z�6�J^�P6�������4��K��Ј`N`d�))����+�-4-�U�'R!����J�|����w�4�k��' {<s�K�Ȯ�b�BS�[���q��G�A�H<��KVB/t�Ebe��d9�Ƶ=�o�
�|�t)���#��`S!�sݑVXy�g���>���۶�շ��e*�����[�Z���Eϫ�a���\�4�ܕP�\�WڧKe6������(��n)u�5
�e�~�[8���m�E�N�lD)Tjd�Pr	O2�5ʥ^dA�9��U�M�.��Q��'x��˫S=l��;ջD�!�����˶:%�u���$gm_�Yl2�Tܢ8i����&&�Q�em1�F����L�C�x�����w,E�"��/+��Ho��&�b�o=~�r�=��>)��'�2	>��ނ�[Ȯ�$2k�"T��4�=��$*����D��'���6{wo����QY�c� �Z�*�Io%N�9_K÷U�QmR%��T�4���D��O����̂yRǨB�Xu�p�ɟ��{�����;��xH�ml�1L��?�K�t�No� /�߆7EX�/.�M�#�9>sKȄ�Mj! ^�dI9�/���N?�*L0�x����u��8H���bC��/2��Wr ��۷�Eg���(x��D��;BK��¬��E��k�mnV*TV!N���nǫ�.
^ɳ
���|r��hm�gZ΁"��/�Ɨ&ﷹ�j��j]���+靌�V���tOlzC�i#��b�*�9�����ɴ�:��_ҫ������G��I��Y�j׬�C�q���o߲&���leIh�`:#p�-�AH�zau2��<r����}A?5�i���xn�>{��kd��+џ2��S����N��u�������MPPwa�Ô� �BU	Ff=�� �V�09�7�n���A<���~��'�U�f��ax���7	8��]i���mcNtGH�aL��9)�!%e�5'}=�����9����$�>�U��K����_�ݫ�r{���{��ޑW<Ǵ�\�K�m�X�����"�q&�3<�)���^�I�\TXu&k ���+&�JMd
��~>��Z�=In>{z�ۻ��8�8J�v;�GvΛ�����������f%#F��6m���r�>FC�������A"T>��竞��տ R~�Va����+��h>�E4o�3�bw����C~��wX{ܫ���7��Q��	�d�/�z:V
����-%�5�U&��D��(~O�[�����������S�2�����\\�QO��{�mE�t}�frjш4���K
�&�r�,�"ד�M#Aú�?��}����`�	O�����Es����J�WX	P��0��욜o�P���ZK*��00�c�d#ǐq�0�#`zNGR�����є�*�Ͻ}��&執��%yV�N������]���)�W�T'��{�����X�	!d�`9~��Y�6��������&����_��������������s�Mp��y�J�eCVk�=~&ڷ/�CB,�2��6��T�Ee�B��"�cX�q�Tn�V��O�4�2��O�C����q8/���n;����k������~��5���H���)�X�N�t� ##ݠ�j�).�4��/�ͺ���3;��βC=�=N��q{5J��l"�X�G"������߾�H��I�I�%q�e*��)J�S����T�����R��?\�����]���Rp��|��r~�����[JO��}�m�p�tOaA�("J�!#I����S���|�>�}�>�JV�%P��8�F�SHn�5�����l:@�u�qC�_+����7�c�������*ֱ�=��={� �T�!b�w@��~+0O�i�5���m�yz��gM0�t�!2�7`r����bI���D�2��X?|����� J\��c����k� O  ƖL��8x�,cЕ�tM�H꧛�~$����p�	�fun�֤�Ak�6�B��|�-R΃o/KC���鸿x�����UO�hm�
YD�ʤ��/��Ф�����1�J�!I蘿�j�MW;+�_���d}�߯���|۴��#��J(i5̳��a�Tn�
aVs��ɨ��E+8g�0>'�?��Y�g�����g1����JLH��=�����kzQ�^����{
�i�1��Cb�8�V �AZ�b��7�J0b���X?-�3��ؼ��1h��?xJ�۾��@zu���b[�mx Z��<k�=��d&�aZ��醜�3���E%�n�.O��|~7�S�h1�˫X<�q*|����>��9gg�>@�cM�m_ρQ8*�>��sJs{8R�g�E��e%�{X����T��d4�����	+7��jv;�b-<5~noG�ݸ�O�<߰����N��D^᷵	���
���� &r�*z�H�#���qDa�*C+,�|9?+�͗�l�ɟ�p��, }ɗ�ȏ	��Gs��,��ޡ����X��J%��%%��R�y���9n K�a3VE���h-�W<��Ke���l6�򢮞      �   R  x�e��R�0���a:��N��Z���B�'��fJH��o���>B^��4�eι|s	x~�89�8aIi�>��p���#Ň�=�5��RF!�����cY����hyE�$�{m����Njmkj��i̽�F���{�^j��lL0�A�y��b_%�u�� &���$ٍ�f�gz��&�+سrC��'��T4��Mnh���`9)�#���,�YW����"��Z8��3���{�*��|�t#��7���47��Ѫ<���:���]ib��i+��-�����U,�˵��lOs��XM�4gU֓VÌP��9`r�ͽ��Xj�     