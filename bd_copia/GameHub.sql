PGDMP  '                    }           GameHub    16.8    16.8 >               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16439    GameHub    DATABASE     o   CREATE DATABASE "GameHub" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE "GameHub";
                postgres    false            �            1259    24864    carrito_producto    TABLE     :  CREATE TABLE public.carrito_producto (
    id integer NOT NULL,
    carrito_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE public.carrito_producto;
       public         heap    postgres    false            �            1259    24863    carrito_producto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carrito_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.carrito_producto_id_seq;
       public          postgres    false    228                       0    0    carrito_producto_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.carrito_producto_id_seq OWNED BY public.carrito_producto.id;
          public          postgres    false    227            �            1259    24848    carritos    TABLE     �   CREATE TABLE public.carritos (
    id integer NOT NULL,
    usuario_id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.carritos;
       public         heap    postgres    false            �            1259    24847    carritos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carritos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.carritos_id_seq;
       public          postgres    false    226                       0    0    carritos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.carritos_id_seq OWNED BY public.carritos.id;
          public          postgres    false    225            �            1259    16655 
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
       public          postgres    false    215                       0    0    categorias_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;
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
       public          postgres    false    217                       0    0    pedido_producto_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.pedido_producto_id_seq OWNED BY public.pedido_producto.id;
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
       public          postgres    false    219                       0    0    pedidos_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;
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
    nombre character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    correo character varying(50) NOT NULL,
    telefono integer NOT NULL,
    nivel integer DEFAULT 0 NOT NULL,
    tipouser character varying(10) NOT NULL,
    clave character varying(100),
    usuario character varying(100)
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            K           2604    24867    carrito_producto id    DEFAULT     z   ALTER TABLE ONLY public.carrito_producto ALTER COLUMN id SET DEFAULT nextval('public.carrito_producto_id_seq'::regclass);
 B   ALTER TABLE public.carrito_producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            H           2604    24851    carritos id    DEFAULT     j   ALTER TABLE ONLY public.carritos ALTER COLUMN id SET DEFAULT nextval('public.carritos_id_seq'::regclass);
 :   ALTER TABLE public.carritos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            >           2604    16686    categorias id    DEFAULT     n   ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);
 <   ALTER TABLE public.categorias ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            ?           2604    16687    pedido_producto id    DEFAULT     x   ALTER TABLE ONLY public.pedido_producto ALTER COLUMN id SET DEFAULT nextval('public.pedido_producto_id_seq'::regclass);
 A   ALTER TABLE public.pedido_producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217            A           2604    16688 
   pedidos id    DEFAULT     h   ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);
 9   ALTER TABLE public.pedidos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            	          0    24864    carrito_producto 
   TABLE DATA           i   COPY public.carrito_producto (id, carrito_id, producto_id, cantidad, created_at, updated_at) FROM stdin;
    public          postgres    false    228   �K                 0    24848    carritos 
   TABLE DATA           J   COPY public.carritos (id, usuario_id, created_at, updated_at) FROM stdin;
    public          postgres    false    226   6L       �          0    16655 
   categorias 
   TABLE DATA           0   COPY public.categorias (id, nombre) FROM stdin;
    public          postgres    false    215   �L       �          0    16659    pedido_producto 
   TABLE DATA           `   COPY public.pedido_producto (id, pedido_id, producto_id, cantidad, precio_unitario) FROM stdin;
    public          postgres    false    217   �L                  0    16664    pedidos 
   TABLE DATA           A   COPY public.pedidos (id, usuario_dni, fecha, estado) FROM stdin;
    public          postgres    false    219   =M                 0    16728 
   plataforma 
   TABLE DATA           ?   COPY public.plataforma (plataforma_id, plataforma) FROM stdin;
    public          postgres    false    224   �M                 0    16670 	   productos 
   TABLE DATA           �   COPY public.productos (id, nombre, descripcion, precio, categoria_id, stock, fecha_lanz, valoracion, imagen, plataforma_id, valoruser) FROM stdin;
    public          postgres    false    221   2N                 0    16677    sessions 
   TABLE DATA           _   COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
    public          postgres    false    222   �a                 0    16682    usuarios 
   TABLE DATA           m   COPY public.usuarios (dni, nombre, apellidos, correo, telefono, nivel, tipouser, clave, usuario) FROM stdin;
    public          postgres    false    223   �c                  0    0    carrito_producto_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.carrito_producto_id_seq', 15, true);
          public          postgres    false    227                       0    0    carritos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.carritos_id_seq', 2, true);
          public          postgres    false    225                       0    0    categorias_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);
          public          postgres    false    216                       0    0    pedido_producto_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.pedido_producto_id_seq', 17, true);
          public          postgres    false    218                       0    0    pedidos_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.pedidos_id_seq', 1, false);
          public          postgres    false    220            d           2606    24872 &   carrito_producto carrito_producto_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.carrito_producto
    ADD CONSTRAINT carrito_producto_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.carrito_producto DROP CONSTRAINT carrito_producto_pkey;
       public            postgres    false    228            b           2606    24857    carritos carritos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.carritos
    ADD CONSTRAINT carritos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.carritos DROP CONSTRAINT carritos_pkey;
       public            postgres    false    226            P           2606    16690     categorias categorias_nombre_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);
 J   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_nombre_key;
       public            postgres    false    215            R           2606    16692    categorias categorias_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_pkey;
       public            postgres    false    215            T           2606    16694 $   pedido_producto pedido_producto_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pkey;
       public            postgres    false    217            V           2606    16696    pedidos pedidos_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public            postgres    false    219            `           2606    16734    plataforma plataforma_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT plataforma_pkey PRIMARY KEY (plataforma_id);
 D   ALTER TABLE ONLY public.plataforma DROP CONSTRAINT plataforma_pkey;
       public            postgres    false    224            X           2606    16698    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    221            [           2606    16700    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            postgres    false    222            ^           2606    16702    usuarios usuarios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (dni);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    223            Y           1259    16703    sessions_last_activity_index    INDEX     Z   CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
 0   DROP INDEX public.sessions_last_activity_index;
       public            postgres    false    222            \           1259    16704    sessions_user_id_index    INDEX     N   CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);
 *   DROP INDEX public.sessions_user_id_index;
       public            postgres    false    222            k           2606    24873 1   carrito_producto carrito_producto_carrito_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carrito_producto
    ADD CONSTRAINT carrito_producto_carrito_id_fkey FOREIGN KEY (carrito_id) REFERENCES public.carritos(id) ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.carrito_producto DROP CONSTRAINT carrito_producto_carrito_id_fkey;
       public          postgres    false    4706    228    226            l           2606    24878 2   carrito_producto carrito_producto_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carrito_producto
    ADD CONSTRAINT carrito_producto_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.carrito_producto DROP CONSTRAINT carrito_producto_producto_id_fkey;
       public          postgres    false    228    221    4696            j           2606    24858 !   carritos carritos_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carritos
    ADD CONSTRAINT carritos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(dni) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.carritos DROP CONSTRAINT carritos_usuario_id_fkey;
       public          postgres    false    223    4702    226            h           2606    16705    productos fk_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_categoria FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON DELETE SET NULL;
 @   ALTER TABLE ONLY public.productos DROP CONSTRAINT fk_categoria;
       public          postgres    false    4690    221    215            i           2606    16735    productos fk_plataforma    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_plataforma FOREIGN KEY (plataforma_id) REFERENCES public.plataforma(plataforma_id) NOT VALID;
 A   ALTER TABLE ONLY public.productos DROP CONSTRAINT fk_plataforma;
       public          postgres    false    4704    221    224            e           2606    16710 .   pedido_producto pedido_producto_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_pedido_id_fkey;
       public          postgres    false    219    4694    217            f           2606    16715 0   pedido_producto pedido_producto_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_producto
    ADD CONSTRAINT pedido_producto_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.pedido_producto DROP CONSTRAINT pedido_producto_producto_id_fkey;
       public          postgres    false    217    4696    221            g           2606    16720     pedidos pedidos_usuario_dni_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_usuario_dni_fkey FOREIGN KEY (usuario_dni) REFERENCES public.usuarios(dni) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_usuario_dni_fkey;
       public          postgres    false    4702    219    223            	   Y   x�m���0C�0EH��H)�t�9��%����1I	 ��Ɛ�H���Vexa��4�\�']��E���v::�.�W��5#���M�73/#N#g         D   x�3�40426153��4202�50�54R0��20�25�&�e�	�`ai��,ohhehfed�M�+F��� V��      �   >   x�3��LI��*MM�/�2�t��+��I�2��M-J�H�K�,��K�2�t>�973�+F��� �t@      �   U   x�E���0����	��K����H�x68
�+S�썵&�L�/#1+RئO���m���^dMlx�9��=��?������          �   x�m��
�0����)|��$��[/�঴�$�_�C�"p��! �|�	�`и�#\!n��;�q��deA�����z�g�@��W�[� ?G�P��k}��4#t��L����H[�Ad87�9��%yY+��	CB         L   x�3����+I�K�W.�,I��2�6�2�&\&�N�\���\f�.��%�9\�z���9�K��b���� ܹ�            x��ZMsǵ]�����K^��"���iK�()$��]�4f`�3���-p�����N�Ty�E�;o^��O�K�9��@����U���~�{�m��~�����N\��i�L[YS���W[crgf�_�i(��>��
�2���2�U�W��-�E�_�|cK�Ĕ�O�/����Ύ������F���>sU����������������@��W{Y��X���gV��m�����W{�ˮ������/6�d6����y��e�ްx��45�h\V�"�WwV��ռ�u��h�	��AdX���B���_�i<lB-
��΋O��%T8����y[��E�,p`X4���R-Bm�, �ҸBlL|A��Cl��q������h0Lv��dw{�h{2���se��i-�ޣ�'{���`K���m���Y(p�|��E{�����j�]]�!5nVw�5�!���SZ�s���YԮ�!��?�nd��w�SX'�u����׎/���u�֦�26��x
�d����P�*�y(��b�*��C�jU�ٺĿ%�FdD��M��EP5?E�֍H��s��(L	�"�<�ȩN�l]݄82� ��G�T�4W���^�bZ�T�ۋyf|�A2�o԰��c�j!��� �E��;����z���F�/}�Mv������8|�u{[��i��P羚�U�W����LؖS&��^�"`�*Y��rip�)��N����CD�9����E�5?��}�����+{�rs�zi�!Zce ����U֖S���M������$�\"���p\]:�u�0��),p�*f��4A�A1�ƥ$�_�[{�!�7.�sg�G���^���>k��}DY(�n�{6yQe#Z�y�����������ٳ7H!��X_�0���ܯ�yS�P3*C�O�ocGf�����|�*��!��]a�9����fޮ�����2L'�t߈��h3�'K\N�w&ۓ}���C����\"r�[���
��/B�9b^��sD�m���		�!E�WΦhS��{�G�}L"C-�~�~�b?DĢp��CQ�Y[Gԓ�$��>8�P,0�os��e(����+�4ڌ~c`@��` cV^���~�6 $��ТA0H�P��Ja��fʨFX�F���'��O��VǒV����_D1��g`�|��?0�KZ�+S��	%��1TP4��ca�l�����-l�yJ{���TN�a�Ҋ�h٥H��x`n�4��}���7@H�YCu8�]m��"G�����rjk����H7^N�Օ+���/��H8�@"'a#����毭�j ,F������5�6#n����\�B˔B��[dOA/r#��Dѧ�x�����깥����G�Aq�0))��`�q�� �A,]!_j[�[CT���>���0���6��������{�����^9엃���\��'��A~n��%r0� 8]��,�<��S�`sս�7_��)K*�Ķt5�.�-FA�X��[�V��0�|u�-Tj٭K%9g��XP�"�ZB��J 6�����n|��z
��되]���
������&�b�	d��nܭ
�j�n~��+_������;��hⓂ ނ$�#�����Ҩ#��(FMS�Վs��>1/�6v�F�kQ6*�-DJ:�F\,���.ZTK�K���DIyWw(�Fԩ����'WA�P�����-����	p�ۂ�Xb�\d̅�&.�j.ƒ�-�VI?J`)����@.��v^	J;��r�nl��p��8<�
�~"������,%�w�o._��u��7�h�����o�e�n	�ef�p�,�N1�o�R7ԜB ++~�f����l0���u���we�{r
����Ml�2���qBJ=n��DJ;ʋ�]�(ۨ!Ü��"9D,���O�����aI�B�i�>���[(\A���(# ����+M�$b���}���u6�������G�)�M��������#��H�������?�}�"m���M4>::@lo>�h�x�ĉ�ʚg�Tpd��3��	�Ȏ�RG�2�}@��]�G��6�A-M�n���k1T�
��vE���5�
̀t�AP�-14B�0v���L\�p�(\)����{Ʋ��HV��ڵ�`�'i7pS�\2�ٕ-~�o \7���m�|l�w�'��ogo6�m<�rK�0�{�W?��zb��>��	|񙒒W-���#@�y�F���N��-���8����ҡ��Ek���#u8 ,�+SQCJ F� ��A��N6aGdK�Q�;£���v��R����������V]Pk?�Tw��G�-	5%�%�Rr<��5����-��r� �p�0�Uw��� U�Z�u�H��/�V9ߤ����W��m�i��M��:��������^���AXaRe��j[I�FXb�F�!?(��m�SH	y�yI��@�
�p�L�r�e�ۮ����Ȯ� �m�G��=� ��a���Ň��oF�ۗg��;Nы�[�.`�]�{�s9��h�ݡ���c7|@VK$�$�U`D�+	��K�MC���em�;E��TlݬͭX�?�!W?}�=����j;k:A���#aD�@�sq3�ul��0j�ܴ%�BiFQ����7p�t�R06��5���s7I�I���\wU*J@���R2��Bʾ%TY��_��m��ۨ�5�s\n���N����E�"P��*0�-�c�Ї�2qf�O�/F�q��2��ci�G��.ާ)�!�n2ؘ��~~L��j�U�ä�4B1��H�fi"��V��à�U��;z�+΢df�9�A�9�	?���B@A�������0�ҊY�f8
��E��$U��/�����x����nD���m�i$�5S�2��cS��@�\�0R ��NA���B�O��G7�$Q�r�(�O�4��<�@�����)
�޳&��[�����;�m�!�(G4�a���m�j�$�_l.��Y����<���71p
�VC�����@�.3�I�ėq3�c�u���0<f�����flYE�P��5d)�I'�G	ɐ$�Օ��-r*9�րi��o?2h��4t��]W^�RyP'�����Bы�`����T�7��nި$���W��x���UQ:=On��zI�͙)��2!���b���$05�~b�ڮ��"c7���Ղ��CNr6���^ohŲp�p$�2�'���gP�؍�K߂MD�dF�37��B����\�Q[Ŕ�HR9�ݐ>'R4���K�ߩ�����˳�I�}M���-�r�?8Ρ=�c���[�Hh�@񔘺'_-t��@�=D}���-�6�������
�9������kk����sD8���2��Lp����R���8`���{P��2lE���>Rّye7X��`(u�F�����]�:i�v2�J�&i
Y��
dN�C�r�n���U�f���f�T��$]B�l����#N���j:��ۋ��)�xo�Z�yl}!�	���7�L�\��X����Nts;ӿ)]��5lw9ŵ��]�B�7���N�R���'�8Am��p�.��2��� 0]뵧:��{�~�]��u�MPY��Ӡ���i�h������#ٰ�:�m���5��/�7����~�ՙ�O,�pަ��$P��?Ώ2���5_z{7�=LSm��Rң����r�⣫��?�'}�/4�5��x墴�
������7n F'��4e�y�Qws��L��ۀ6�ȑ2������2T������.�i5�ʹV���6�j�"ld�_��^#}.�Ң�l6\߂
�vU�v^�V�yno�����0����Gf���b��34�9���)\��}�e�r�Hh��B�Qd����q�^���[%��o�?j>��P���k]u�TW.�^뙟�T�`���Z���#�	�e��j�!�\��(]����S�u���ᷛ�����6���p�y����o9T�Q9q]K�% �  �>�P�A��s�+�@��g_�=���Ь~F?5c�h��
x��TH9nf��,嚕T �u��#��w�Y�Թ�J�%V��{�\��u�k�����M�G:ҍ]�wW�;a�V���=O�{�D��f��Y�j�1�.@+x� S���u�KxA�s9�uf���VzQ��4�L���ئK@a`2a�F�c���vh��kXH�ʹqN~:�oz������^��_�8�+j�T�ͱ����0]��n��=|=�k��w�����.��sz��g�]i���}70�Q�Q2���^�j���`e^9Z�bd^�
]�Rgu��[��N��h-��K������U��.K]c�B�ڔ�~�j��v7[2�׆�gZ��7��P������U�(9P�J�=��"p�11�fd���8?5�ռϖd͕�����4���o)��q����n/���)+�ti�أt=��=������ӽ�������!���-u��i��2�;�/����V#F�\؜O���<���-әG�+��_�+�%�[E����~C����_t�Q�`#9�P�f�d�M��=�٘�]�9�0�%���5`��A���z��#����\�#��\WZ����,?�Эe�-���KS�a����'Wx�X0����QgK��,�}SZ3)� ���L.9���K�D��t��
{���S�t��������7������xp"w��9;���Y�S�Y����'h����+M��S��q~�.���K|�{vL�F]�������u�,�uL�qP�y����0%��
���[z���4�	(�v�wV9/��3�
�+�e���2Bg��U_	��2=l��7�0�J���,d"���T����v���Vb'Q)���B�������J�H����������1#���pr:I�@���hkk�� �l�         �  x��Q�n�@<�_�q�bπ�x�=ؼ1�?x(ό1��!��w���H+��Շ*u��VM�_��g�K>Hx*��^.����@j��.:�������3�O9cץ� ҏ0�)Z	�$(�gI ��Y?�G�*b����Hɗ2�@4�����q���������"�\�X��]�L�&�cн�K'��C�u{�-�
TG�L 2h8�Ȥ-b�zu:5��p��W��K��c�b=��<�-�?5��$8H�!_C���U�n����(�N���f���@�uIC���8��c�cDI2l�z	��瑜�q��[tYP��Mh�ϱ<�������{*�W���F��꫕���+�z����$6��s�}'4��J��0/S����A*X�m6�24�슘�}����q��bfpn8�5�o�,�v<�o�#4��3f�n22��מ<�yLx��o��|�XU
�         K  x�u�ˎ�@�u����"�nh@F�k�f6�F(��f�����FZ;'q�W*��rr�(�JO�;`H��d��O�� &�ܠ��a>$P��� @��"+��Ծ��KY���қ�9;;�?�+�$�����Zر|$�)����-����κM纡%��fc`#^>m����};DP�ь|K��zuPjG��W��j��$Ы�|8r��c;{	N¸����i�q7���`�w���2L��8w������[d�BO5����c�c�P�y��eb�/0U��aެ�M���H�swC�'X��f`I(��.<O	9l���N��l��>���|~�o7R����<]H	i��е�����Wf���p3�`���'��!��A{j�<�����F"��Z�
�3�n!8�xZZA���}:QDC�5�w��A��)�=\>��������"��h��gQ�YjW�4���&�4O��0�[�<��Y�s��[%w�&x%'�)bZ^/"�"���G���(���'�.XB}�
m^y����#��V����˓�+��[$s~���ux�C����9���H'�     