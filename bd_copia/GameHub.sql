PGDMP      .                }           GameHub    16.8    16.8     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16439    GameHub    DATABASE     o   CREATE DATABASE "GameHub" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE "GameHub";
                postgres    false            �            1259    16682    usuarios    TABLE     �  CREATE TABLE public.usuarios (
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
       public         heap    postgres    false            �          0    16682    usuarios 
   TABLE DATA           m   COPY public.usuarios (dni, nombre, apellidos, correo, telefono, nivel, tipouser, clave, usuario) FROM stdin;
    public          postgres    false    223          /           2606    16702    usuarios usuarios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (dni);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    223            �   �  x�u�ɲ�H�u�w�$��JT�k�hԆ!E�L@Hަ����z_��t��?##�?O��Ƽ J�e0B��;�-�f��8(O �e�̟k� �Ga
>8��r4���)i�����|���:n������a����U.�+K�,��y}���)�88�����
�.+��U����r_"*B�S�k�%�[hS�M+cͦ�d7K)��S��$
������2G����U�`�����C�{�����~�ɶXY�V�x���!E��=����N$����PbS�0�jN�:��X��n����W7���C���)C�8��?���7m�Y�۶)��F�Cp����Yl_��̈[[���=�j@��b0�8}������ɰ�o��BѫMPHl�����I)�\�K���P�ۉ�W�^��
}N笸�`�`��� ҥ�.���.��e�fj�L��.^Ak/��t�߯�=�f��9��nA2솝���X�i>3?���[�W��[����a?u�\2�)�����摑�瀤����#5�)���z�:���9���w��5{����.y�-�f��	�H��m�p/[JR���6p�G���Y��突�;�ׅ�;�*��cX��C|��#�D��]LCKNΝ�d�I�F�ץ{��m�\o�&
Ws�:���%X��%��A�/��{��!/��g��*����v_ٲ�e�5�/���Ȭ�s�w�[JA�D�|��/j4�% �=     