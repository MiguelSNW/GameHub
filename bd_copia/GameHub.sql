PGDMP  %    3                }           GameHub    16.8    16.8 )    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16439    GameHub    DATABASE     o   CREATE DATABASE "GameHub" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE "GameHub";
                postgres    false            �            1259    16497 
   categorias    TABLE     g   CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.categorias;
       public         heap    postgres    false            �            1259    16496    categorias_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categorias_id_seq;
       public          postgres    false    222            �           0    0    categorias_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;
          public          postgres    false    221            �            1259    16479    pedido_producto    TABLE     �   CREATE TABLE public.pedido_producto (
    id integer NOT NULL,
    pedido_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);
 #   DROP TABLE public.pedido_producto;
       public         heap    postgres    false            �            1259    16478    pedido_producto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pedido_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.pedido_producto_id_seq;
       public          postgres    false    220            �           0    0    pedido_producto_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.pedido_producto_id_seq OWNED BY public.pedido_producto.id;
          public          postgres    false    219            �            1259    16465    pedidos    TABLE     �   CREATE TABLE public.pedidos (
    id integer NOT NULL,
    usuario_dni character varying(9) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'pendiente'::character varying NOT NULL
);
    DROP TABLE public.pedidos;
       public         heap    postgres    false            �            1259    16464    pedidos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.pedidos_id_seq;
       public          postgres    false    218            �           0    0    pedidos_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;
          public          postgres    false    217            �            1259    16458 	   productos    TABLE       CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(200) NOT NULL,
    precio numeric(10,2) NOT NULL,
    categoria_id integer NOT NULL,
    stock integer DEFAULT 1 NOT NULL
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    16597    sessions    TABLE     �   CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);
    DROP TABLE public.sessions;
       public         heap    postgres    false            �            1259    16452    usuarios    TABLE     �  CREATE TABLE public.usuarios (
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
       public         heap    postgres    false            7           2604    16510    categorias id    DEFAULT     n   ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);
 <   ALTER TABLE public.categorias ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            5           2604    16511    pedido_producto id    DEFAULT     x   ALTER TABLE ONLY public.pedido_producto ALTER COLUMN id SET DEFAULT nextval('public.pedido_producto_id_seq'::regclass);
 A   ALTER TABLE public.pedido_producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            2           2604    16512 
   pedidos id    DEFAULT     h   ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);
 9   ALTER TABLE public.pedidos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            �          0    16497 
   categorias 
   TABLE DATA           0   COPY public.categorias (id, nombre) FROM stdin;
    public          postgres    false    222   u0       �          0    16479    pedido_producto 
   TABLE DATA           `   COPY public.pedido_producto (id, pedido_id, producto_id, cantidad, precio_unitario) FROM stdin;
    public          postgres    false    220   �0       �          0    16465    pedidos 
   TABLE DATA           A   COPY public.pedidos (id, usuario_dni, fecha, estado) FROM stdin;
    public          postgres    false    218   y1       �          0    16458 	   productos 
   TABLE DATA           Y   COPY public.productos (id, nombre, descripcion, precio, categoria_id, stock) FROM stdin;
    public          postgres    false    216   *2       �          0    16597    sessions 
   TABLE DATA           _   COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
    public          postgres    false    223   �3       �          0    16452    usuarios 
   TABLE DATA           m   COPY public.usuarios (dni, usuario, clave, nombre, apellidos, correo, telefono, nivel, tipouser) FROM stdin;
    public          postgres    false    215   YD       �           0    0    categorias_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);
          public          postgres    false    221            �           0    0    pedido_producto_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.pedido_producto_id_seq', 17, true);
          public          postgres    false    219            �           0    0    pedidos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.pedidos_id_seq', 1, false);
          public          postgres    false    217            A           2606    16504     categorias categorias_nombre_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);
 J   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_nombre_key;
       public            postgres    false    222            C           2606    16502    categorias categorias_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_pkey;
       public            postgres    false    222            ?           2606    16485 $   pedido_producto pedido_producto_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pkey;
       public            postgres    false    220            =           2606    16472    pedidos pedidos_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public            postgres    false    218            ;           2606    16462    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    216            F           2606    16603    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            postgres    false    223            9           2606    16457    usuarios usuarios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (dni);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    215            D           1259    16605    sessions_last_activity_index    INDEX     Z   CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
 0   DROP INDEX public.sessions_last_activity_index;
       public            postgres    false    223            G           1259    16604    sessions_user_id_index    INDEX     N   CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);
 *   DROP INDEX public.sessions_user_id_index;
       public            postgres    false    223            H           2606    16505    productos fk_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_categoria FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON DELETE SET NULL;
 @   ALTER TABLE ONLY public.productos DROP CONSTRAINT fk_categoria;
       public          postgres    false    222    216    4675            J           2606    16486 .   pedido_producto pedido_producto_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pedido_id_fkey;
       public          postgres    false    220    218    4669            K           2606    16491 0   pedido_producto pedido_producto_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_producto_id_fkey;
       public          postgres    false    220    216    4667            I           2606    16473     pedidos pedidos_usuario_dni_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_usuario_dni_fkey FOREIGN KEY (usuario_dni) REFERENCES public.usuarios(dni) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_usuario_dni_fkey;
       public          postgres    false    215    218    4665            �   m   x�%�;
1���ň��rP�QK�G|h`��M��\���ԧAB�~'hߞJ�q��q���T<s�s|���s�].���h\bc��2W��4�kjx�1�t����Kz!      �   w   x�M�Q� C��0fQ����\�b4>��H��^��j�J��H����d�V�nP�Q���mY�S�������"� � -�v#�^(�7��� #r����^��]K)s�%[      �   �   x�m�I
A�u�^�%���9gp�t� ��x~m�Y>��! m��!.A�v��h����]�ӵnJ�v%Ҋ��<�)?�2��E�IiS$��H���C��k���H��|�Sb fv/������$���-0��"u��$��T���<ϕRo-�_      �   �  x�U�Mn�@�לS�,Yv���6N��F�0Zf=�3#��mr����J)5������}��{���pg���+;K��e
q8'�}']c}�{v�V�I+�������/�l�*�*( ������:�u-��z���m�Y�t'�>��o7~��)p�󔉙���j�E	o{n����O��kߡ���Zh�+Z��Q>�bbJ��?8�
��}����Q���ꦯ�AcC�Q�C^�,;i���c���������i{Gև��Q,���;B���D9L*!_�9\�p���ǋ�R�n�x�����`s7d9��7�r`��
Rz�eP���	L'fk���^�a�kn���TT����1J�1��(G��!�p޻��T���A3-��w}���WN�J�G��gz���>�袂�N6��U^��9E�,r�8�+���y����G�����c�rI�      �      x�՛K��v�ǟ�b��whnjN���M�F����h���r��q�J2JjW%屼U�P�o�w��aw!XȎ���t;.��qڿ���n��|H\ok����@\�)���:_�:�����_�K˯���?�{�_�7��_�?������?�<�� ����y�����_{���u��~��X��k!�:���|\�zI���3}Ak�=2��3� @� �,�'�걄4tbf�� �u��]�Sf;5o��܋'�����������œ\՝7�)no�ô~�",R�xe��z�fp�k1	��#Xg��v�\��K$�G����ܩ��s]/�8V�ضyo�ks��Wj>����׻>E��� KY��ZY�{���ؒ��0S��{e�,Ϣ��r�2{/ ��W��8p�}�N�(&F�'��P"�ج��2Vujk�N1��p��8NmJ�Z��S��zI��l
�R׵�G]}V����8�б{7���0Tp�K����D��$� �1u�4F
���2u���8c�����ߡ�.�N�۫��uYo��q;�/'���0���bڼU�Uز*��K����'�0C�i�!11֋"���JY�v�^���_c7F�ϩ~���6�j�c��0&!0�Z&QQ%�#���ns�B�{XX��5����?*f�u�X�#I([���S�۹�y{rշF6޽duq��a�a9�M�p���̈́��ۚ��EK�ƍ��na��Y��F�U�A5SǸ.�g����z��8���i���|EF�d��@-���IP��i�J̦:����@]CI�16���Pϵ����oá,@���yۺ�(n���`��vϣ�\6� <W^�~,�G4��. F6x6�%"�a�a2�&
i�R��Ю{����p��B�mU�e��SH���z�W��Զ�3W�:������x�<���0 �n��f�}R�朒��T33�f��I��.`�\�X��Drt�!]�k�E�!s�K7�'�r��:�NM,A���8��9���t�`Z&�Kb �G��Cp �YF-j�/�!�ʢ:eWgy9zC���S��:8J����O��0¥�06;T��K�����F�"��
@�(��4)���"�(�zL��:���_p��#PUy�;��-�裗Z�}�_G��o�ëqDټGw�)n?���u������#��M"N��y�N��["v7�K:����<�ߍA�,��FIن�B�z� �X�6��dM�c���뽺}zR*w�1-�Yh�=y���;9�S��B�``շ�(\��@]��rҷ�&���<�xϊ�W�F��2�]�贺~:���J|�
�b!�ͫ���%v��f��q���:dP�D]�m�i))������^R$A{��(w��"������&rl�_^��q�@q��4�fB�5�D���(Q�c�(M���#�#3�="��"dy�Ý�G|��:�'���gΩ��fK�-����^)a԰d-��X��%jr��r��e"�i�"&��ө�
��,���ck��S��՟��s�"UK����N��k{6�ꚟ.z$Vo���������Q]�	���K���Nɬlf"�n�\M�]���"yq:ճ6|�W�zЮ�g$Ήk�b9�Pڎmwl>�q��$.1��)�W2k*��У|�Fl�q�
õGl�1���ٗ)b%�:�(Ke'���j����@�&����4�c��,���E�S]��Z��rl{"fc&�5��mk�K��;��I��M�wS�(b%�������v,lɼ�������l���
wŕOw�|�T� �Q�<B7V)Ջ[,�$0�9��c tMh�}B��m1b%�$d��;(���s��6�㻗i��XZ��4?�Ǖ~:�#�����YK;�WVр��|�j\�1l�0k���"��Ӥ_��~"P��m������x�^:3x%��餴��C�^t�t��:-�(e"*bZOY�?2���Ni�:\��&$����Ty���W��~�r���qo8��;M�݋G�W�X�i�͘�����ΧC��_��E�qhɃ�Z�-$��[]��W�h��������Y�_P_��ຆ��^�JB���FS�}׹�v>]r=��p���'��d��B
�Ӻ�U��Թљ���_3���\�QA2�~���qEȋ���pɦ��K��Q�P�V�3�6������iY�bN���f�;.��I����J���5F��Lv`����e7�W(BY�smk���옹����h�r�ؓr_�.���ӊ�	�EG�z��& ��d�*��[`t���{\�AH7R�u�P�;���$��w�Zl�le)���E���\������U��55{@)���ߢ���XJ�V`A��P��ص�.N`�_���Β���<|9O������ε�k^����6�ټ�#M�3�\�kkv �7}@���y�-��t\cm�/�ЭUia#�z�N�>�ڌ�a�3V��OO�U������vA5ʤ�g"�״�պ�&Ď�IԀ��e&�!���.C�;��<O�Z�E$��qܜB��wKn���8k���a~GP��;o(3ʊ<D��r�3���������v]���H�k�2�{�ZF��������:ì=&:].�c;�88^1�?;H!!��Ԁ35�ؼ���e��%sA��<zS��i���wMVo�"�R��\�8f����~��fv]~\��'���Ǘ1�ݐ<J緹�y�vX7l2��k	���45�؜ݶ�:��/��dY]�����x9Tq��Xl�)|ݎ��T��3g�ښ����%-���!%"��
Y1������"���S�fٜ�D���.���bz+>��)z�C���� v1��l��W}���TF��K5�(a�\3�yDl���C��΃&����D�Ef����<��JX�h�O����Uw�UZH��[��^ݦ�U牙��O��E�4K?쯹�e�m*���d^n�=2�1�����d�6E��"22g�Wp[.��-���q�:'�Fd�-ؔ�9;;ѧ�t%����sŵO)�C�㦸�4�X��2$l�r�v7*D���Bz#݊�s��mbae%_|%��|�x�V�_����ʩ����>}p�b��ջZ�fD�h��S�0FA��i�9F��mj�N�for=�Mf`�.�آ.ů� 4v�?ϗJ�K(�>]0��6A&82�8b�/��k��P�{ܠ����+�h�G�D�ȾB��n<�!n%�j�z�B�Y/�tЅ�-H~ɯ��Ӯ)D{h9�@��O+(����{q��ǸN��`2��[�񝅫��篟8�E���b���~��T4�R����┠;M��K���&��M_��	���p�{�`fA�z��S�3�q�޾IQ����/�xq�|�����
i-�}��4}��˷����Z�� h��["B:��lJ[��5�x�R�*���t�d-$K���e�J�V]�.�xڶ�DBꄻعV�l�եH.z6,/ƑV
�5��J*cA?��(�29u[ԇB.�ְ;�M����E���^K�W��Ӟ��^��0L�;8�{�2�t�>� �.��3��7�!Ħ�E<zǎ�F�=��g�鑘�����#������^��r�/Q����� ��}]�򍷫�D�����@g��O�{R 0PG��r���r�� �-_	msLF���˅���6��a�����rM9�dlcV�ư����N�۾�p�%�Cݔ)��DZJL;7@�\&�N�ߡ�R���>��Z-����J��s8��=��������r��8F���M�4*fƓ_���KL��(IM&÷y��!f��~"/� ��>�"��ʈ��^Z�g�:q��ֆ�"�j^����2������p%!d���<�#ؠ8�":����eM&{=�\,vy��h��?q�f,2����x����mz�kxcC��6�����2�,#3���8�}oM�)+W
?�r|����}�6m��O7>K�[��Xs(�Vۼq�Ф��t�[4@j�f�R�J���b���+ �O�l���y�3�k6tm��p0�� E   ��x�}&�r�Mw���f-y�ߩ8
Tx�Ժ~�'�Cn�*�������t���4��8�����X,�Ry�P      �   R  x�e��R�0���a:��N��Z���B�'��fJH��o���>B^��4�eι|s	x~�89�8aIi�>��p���#Ň�=�5��RF!�����cY����hyE�$�{m����Njmkj��i̽�F���{�^j��lL0�A�y��b_%�u�� &���$ٍ�f�gz��&�+سrC��'��T4��Mnh���`9)�#���,�YW����"��Z8��3���{�*��|�t#��7���47��Ѫ<���:���]ib��i+��-�����U,�˵��lOs��XM�4gU֓VÌP��9`r�ͽ��Xj�     