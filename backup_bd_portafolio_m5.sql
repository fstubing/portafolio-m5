PGDMP         !                {           portafolio_m5    15.1    15.1 O    e           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            f           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            g           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            h           1262    24677    portafolio_m5    DATABASE     ?   CREATE DATABASE portafolio_m5 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';
    DROP DATABASE portafolio_m5;
                postgres    false            ?            1259    32825    categoria_producto    TABLE     ?   CREATE TABLE public.categoria_producto (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(100)
);
 &   DROP TABLE public.categoria_producto;
       public         heap    postgres    false            ?            1259    32824    categoria_producto_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.categoria_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.categoria_producto_id_seq;
       public          postgres    false    219            i           0    0    categoria_producto_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.categoria_producto_id_seq OWNED BY public.categoria_producto.id;
          public          postgres    false    218            ?            1259    32801    categoria_usuario    TABLE     ?   CREATE TABLE public.categoria_usuario (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    ver_bd boolean,
    modificar_bd boolean,
    descuentos_min boolean,
    descuentos_max boolean,
    promociones boolean
);
 %   DROP TABLE public.categoria_usuario;
       public         heap    postgres    false            ?            1259    32800    categoria_usuario_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.categoria_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.categoria_usuario_id_seq;
       public          postgres    false    215            j           0    0    categoria_usuario_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.categoria_usuario_id_seq OWNED BY public.categoria_usuario.id;
          public          postgres    false    214            ?            1259    32864    compra    TABLE     ?  CREATE TABLE public.compra (
    id integer NOT NULL,
    id_proveedor integer NOT NULL,
    tipo_documento character varying(10) DEFAULT 'factura'::character varying NOT NULL,
    numero_documento integer NOT NULL,
    fecha date NOT NULL,
    neto integer NOT NULL,
    iva numeric NOT NULL,
    bruto integer NOT NULL,
    CONSTRAINT compra_check CHECK (((bruto)::numeric = ((neto)::numeric + iva)))
);
    DROP TABLE public.compra;
       public         heap    postgres    false            ?            1259    32863    compra_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.compra_id_seq;
       public          postgres    false    225            k           0    0    compra_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.compra_id_seq OWNED BY public.compra.id;
          public          postgres    false    224            ?            1259    32880    detalle_compra    TABLE     ?   CREATE TABLE public.detalle_compra (
    id integer NOT NULL,
    id_compra integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    precio integer NOT NULL
);
 "   DROP TABLE public.detalle_compra;
       public         heap    postgres    false            ?            1259    32879    detalle_compra_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.detalle_compra_id_seq;
       public          postgres    false    227            l           0    0    detalle_compra_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.detalle_compra_id_seq OWNED BY public.detalle_compra.id;
          public          postgres    false    226            ?            1259    32928    detalle_venta    TABLE     ?  CREATE TABLE public.detalle_venta (
    id integer NOT NULL,
    id_venta integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    precio_unidad integer NOT NULL,
    descuento integer DEFAULT 0,
    precio_final integer,
    CONSTRAINT detalle_venta_check CHECK (((descuento)::numeric < (((precio_unidad * cantidad))::numeric * 0.5))),
    CONSTRAINT detalle_venta_check1 CHECK ((precio_final = ((cantidad * precio_unidad) - descuento)))
);
 !   DROP TABLE public.detalle_venta;
       public         heap    postgres    false            ?            1259    32927    detalle_venta_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.detalle_venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.detalle_venta_id_seq;
       public          postgres    false    231            m           0    0    detalle_venta_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.detalle_venta_id_seq OWNED BY public.detalle_venta.id;
          public          postgres    false    230            ?            1259    32832    producto    TABLE     i  CREATE TABLE public.producto (
    id integer NOT NULL,
    id_categoria integer NOT NULL,
    nombre character varying(50) NOT NULL,
    numero integer NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    precio numeric NOT NULL,
    CONSTRAINT producto_precio_check CHECK ((precio >= (0)::numeric)),
    CONSTRAINT producto_stock_check CHECK ((stock >= 0))
);
    DROP TABLE public.producto;
       public         heap    postgres    false            ?            1259    32831    producto_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.producto_id_seq;
       public          postgres    false    221            n           0    0    producto_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;
          public          postgres    false    220            ?            1259    32849 	   proveedor    TABLE       CREATE TABLE public.proveedor (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    domicilio character varying(100),
    ciudad_o_comuna character varying(50),
    telefono bigint,
    email character varying(50) NOT NULL,
    rut character varying(13)
);
    DROP TABLE public.proveedor;
       public         heap    postgres    false            ?            1259    32848    proveedor_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.proveedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.proveedor_id_seq;
       public          postgres    false    223            o           0    0    proveedor_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.proveedor_id_seq OWNED BY public.proveedor.id;
          public          postgres    false    222            ?            1259    32808    usuario    TABLE       CREATE TABLE public.usuario (
    id integer NOT NULL,
    id_categoria integer NOT NULL,
    empresa boolean,
    rut character varying(13) NOT NULL,
    nombre character varying(100) NOT NULL,
    nombre_representante_legal character varying(100),
    rut_representante_legal character varying(13),
    domicilio character varying(100),
    ciudad_o_comuna character varying(50),
    telefono bigint,
    email character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    activo boolean DEFAULT true
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            ?            1259    32807    usuario_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    217            p           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public          postgres    false    216            ?            1259    32903    venta    TABLE     %  CREATE TABLE public.venta (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo_documento character varying(10) DEFAULT 'boleta'::character varying NOT NULL,
    numero_documento integer NOT NULL,
    fecha date NOT NULL,
    neto integer,
    iva numeric,
    bruto integer
);
    DROP TABLE public.venta;
       public         heap    postgres    false            ?            1259    32902    venta_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.venta_id_seq;
       public          postgres    false    229            q           0    0    venta_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.venta_id_seq OWNED BY public.venta.id;
          public          postgres    false    228            ?           2604    32828    categoria_producto id    DEFAULT     ~   ALTER TABLE ONLY public.categoria_producto ALTER COLUMN id SET DEFAULT nextval('public.categoria_producto_id_seq'::regclass);
 D   ALTER TABLE public.categoria_producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            ?           2604    32804    categoria_usuario id    DEFAULT     |   ALTER TABLE ONLY public.categoria_usuario ALTER COLUMN id SET DEFAULT nextval('public.categoria_usuario_id_seq'::regclass);
 C   ALTER TABLE public.categoria_usuario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            ?           2604    32867 	   compra id    DEFAULT     f   ALTER TABLE ONLY public.compra ALTER COLUMN id SET DEFAULT nextval('public.compra_id_seq'::regclass);
 8   ALTER TABLE public.compra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            ?           2604    32883    detalle_compra id    DEFAULT     v   ALTER TABLE ONLY public.detalle_compra ALTER COLUMN id SET DEFAULT nextval('public.detalle_compra_id_seq'::regclass);
 @   ALTER TABLE public.detalle_compra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            ?           2604    32931    detalle_venta id    DEFAULT     t   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN id SET DEFAULT nextval('public.detalle_venta_id_seq'::regclass);
 ?   ALTER TABLE public.detalle_venta ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            ?           2604    32835    producto id    DEFAULT     j   ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);
 :   ALTER TABLE public.producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            ?           2604    32852    proveedor id    DEFAULT     l   ALTER TABLE ONLY public.proveedor ALTER COLUMN id SET DEFAULT nextval('public.proveedor_id_seq'::regclass);
 ;   ALTER TABLE public.proveedor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            ?           2604    32811 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            ?           2604    32906    venta id    DEFAULT     d   ALTER TABLE ONLY public.venta ALTER COLUMN id SET DEFAULT nextval('public.venta_id_seq'::regclass);
 7   ALTER TABLE public.venta ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    229    229            V          0    32825    categoria_producto 
   TABLE DATA           E   COPY public.categoria_producto (id, nombre, descripcion) FROM stdin;
    public          postgres    false    219   Ga       R          0    32801    categoria_usuario 
   TABLE DATA           z   COPY public.categoria_usuario (id, nombre, ver_bd, modificar_bd, descuentos_min, descuentos_max, promociones) FROM stdin;
    public          postgres    false    215   ?a       \          0    32864    compra 
   TABLE DATA           m   COPY public.compra (id, id_proveedor, tipo_documento, numero_documento, fecha, neto, iva, bruto) FROM stdin;
    public          postgres    false    225   b       ^          0    32880    detalle_compra 
   TABLE DATA           V   COPY public.detalle_compra (id, id_compra, id_producto, cantidad, precio) FROM stdin;
    public          postgres    false    227   ?b       b          0    32928    detalle_venta 
   TABLE DATA           t   COPY public.detalle_venta (id, id_venta, id_producto, cantidad, precio_unidad, descuento, precio_final) FROM stdin;
    public          postgres    false    231   c       X          0    32832    producto 
   TABLE DATA           S   COPY public.producto (id, id_categoria, nombre, numero, stock, precio) FROM stdin;
    public          postgres    false    221   d       Z          0    32849 	   proveedor 
   TABLE DATA           a   COPY public.proveedor (id, nombre, domicilio, ciudad_o_comuna, telefono, email, rut) FROM stdin;
    public          postgres    false    223   ?d       T          0    32808    usuario 
   TABLE DATA           ?   COPY public.usuario (id, id_categoria, empresa, rut, nombre, nombre_representante_legal, rut_representante_legal, domicilio, ciudad_o_comuna, telefono, email, password, activo) FROM stdin;
    public          postgres    false    217   &f       `          0    32903    venta 
   TABLE DATA           j   COPY public.venta (id, id_usuario, tipo_documento, numero_documento, fecha, neto, iva, bruto) FROM stdin;
    public          postgres    false    229   5h       r           0    0    categoria_producto_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.categoria_producto_id_seq', 5, true);
          public          postgres    false    218            s           0    0    categoria_usuario_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.categoria_usuario_id_seq', 5, true);
          public          postgres    false    214            t           0    0    compra_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.compra_id_seq', 6, true);
          public          postgres    false    224            u           0    0    detalle_compra_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.detalle_compra_id_seq', 9, true);
          public          postgres    false    226            v           0    0    detalle_venta_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.detalle_venta_id_seq', 33, true);
          public          postgres    false    230            w           0    0    producto_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.producto_id_seq', 8, true);
          public          postgres    false    220            x           0    0    proveedor_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.proveedor_id_seq', 5, true);
          public          postgres    false    222            y           0    0    usuario_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.usuario_id_seq', 8, true);
          public          postgres    false    216            z           0    0    venta_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.venta_id_seq', 15, true);
          public          postgres    false    228            ?           2606    32830 *   categoria_producto categoria_producto_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.categoria_producto
    ADD CONSTRAINT categoria_producto_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.categoria_producto DROP CONSTRAINT categoria_producto_pkey;
       public            postgres    false    219            ?           2606    32806 (   categoria_usuario categoria_usuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.categoria_usuario
    ADD CONSTRAINT categoria_usuario_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.categoria_usuario DROP CONSTRAINT categoria_usuario_pkey;
       public            postgres    false    215            ?           2606    32873    compra compra_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    225            ?           2606    32885 "   detalle_compra detalle_compra_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT detalle_compra_pkey;
       public            postgres    false    227            ?           2606    32935     detalle_venta detalle_venta_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_pkey;
       public            postgres    false    231            ?           2606    32965    venta numero_documento 
   CONSTRAINT     ]   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT numero_documento UNIQUE (numero_documento);
 @   ALTER TABLE ONLY public.venta DROP CONSTRAINT numero_documento;
       public            postgres    false    229            ?           2606    32842    producto producto_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    221            ?           2606    32856    proveedor proveedor_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_email_key;
       public            postgres    false    223            ?           2606    32854    proveedor proveedor_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.proveedor DROP CONSTRAINT proveedor_pkey;
       public            postgres    false    223            ?           2606    32818    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public            postgres    false    217            ?           2606    32814    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    217            ?           2606    32816    usuario usuario_rut_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_rut_key UNIQUE (rut);
 A   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_rut_key;
       public            postgres    false    217            ?           2606    32912    venta venta_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public            postgres    false    229            ?           2606    32874    compra compra_id_proveedor_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedor(id);
 I   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_id_proveedor_fkey;
       public          postgres    false    223    225    3248            ?           2606    32886 ,   detalle_compra detalle_compra_id_compra_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_id_compra_fkey FOREIGN KEY (id_compra) REFERENCES public.compra(id);
 V   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT detalle_compra_id_compra_fkey;
       public          postgres    false    227    225    3250            ?           2606    32891 .   detalle_compra detalle_compra_id_producto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_compra
    ADD CONSTRAINT detalle_compra_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id);
 X   ALTER TABLE ONLY public.detalle_compra DROP CONSTRAINT detalle_compra_id_producto_fkey;
       public          postgres    false    221    227    3244            ?           2606    32941 ,   detalle_venta detalle_venta_id_producto_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto(id);
 V   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_id_producto_fkey;
       public          postgres    false    221    3244    231            ?           2606    32936 )   detalle_venta detalle_venta_id_venta_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES public.venta(id);
 S   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_id_venta_fkey;
       public          postgres    false    3256    231    229            ?           2606    32843 #   producto producto_id_categoria_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria_producto(id);
 M   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_id_categoria_fkey;
       public          postgres    false    3242    219    221            ?           2606    32819 !   usuario usuario_id_categoria_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria_usuario(id);
 K   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id_categoria_fkey;
       public          postgres    false    3234    217    215            ?           2606    32913    venta venta_id_usuario_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);
 E   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_id_usuario_fkey;
       public          postgres    false    217    3238    229            V   i   x?3??-?J-?LN̩JL?W(H,JT ?+$????$sqf??&?????AU?ss??e?V??J?M?/V 
U?p?eޘ?? ,T?e
?KĔ????? n_=e      R   K   x?3?L??I?L??2?,??)K-?
1?1gRQ~^U*X,?e??????2?L.-JL?/?? ?b???? |       \   ?   x?M?AB!????.Z:?w7/&???UhP6??/0???=_?N?V?J?b?yp??*?CAiX???a?i??h??iz1E,????!|?q(C????g???U??y#VF?=??g??5r?????4a      ^   \   x?-??? ??c?Pw??s??jL???R?%N0&?ΆA?!܊8???!	?[l6???N?L??????"$?Z?7?08 ?C?}D???      b   ?   x?e?m?? E?b^??{?????8??i́?A?J+???Rc-
Z?r??A-??b??5??F?F?>?7<???Bh??d3?=q??ڭ??"?????!?~?????>?q??4x????????$???>?????m`q?Ի?\?\??j?v???('??s^E?梖B??)9???sPc?????xΘl??t???3????-s?ϟ??2r^c      X   ?   x?M?Kn?0DףS??~???t?J??T6?Ȣ?/??h7? >?0""P???F?6}!^?'???3		_t?S?r]?}T;?]???93a???i????Ϻ?))v???Q?E?37>NF?e|??$?Qw??????F;??????u?=)??r?Zi??????~?@)?_5l0?:???k??
??????y}1?|\wP?      Z   1  x?]?An? E?p
.dlc???f?A?`?T?&G?r?$R?
?b???g?G???=x??	??] ?zlbOOĤ?#??A΃?+??޻??@?????4?/?.??>`??
+??!???n?????4??2?^?OQ+???7?'R?M?3?ɵ??d??i???? K????B+?H???????p?4?1??3ټ+웭??c*?{????t??E|^???p???M??IRI?,??r?ߢus>Lj\??]vos:?D?Q?'.BA%?Y????!?z??H鷓??R????      T   ?  x?m?MΛ0?דS? Ų????	z?o3???`d?H?m??"???u?DU?"1"?????K???Zn_UY?rG????	9?y@?V??zwˍV??e?|H??ŕw???@?Ni???p}k޿?8yއd?(m ?j?????!?B???<E?6???F????G*??0?(X????????ʀߦ?l?E2?"$27c??ca?Z?gd?3?Bh~u?Ѓ?	???????y6??翌ctY-???GL??w??0?1̇??"?ж?}U??l?SOAqZ???Q0!?l?6??*R??[?? ?D????????J+?5???????u?{U??e??}?-9?V?o??2????:?zc?<!??ń?'!a?\́?aə&h?Ғ?XPl??RϪ??2?İ?j???????????d?9C??L.Ƕ??zϥ? ׂ.{\
Ʌ???W\??e?I?]1?ձ?G2ِ?ra0?? c۶S????X????N ?g      `   ?   x?M?An1E?pG???ܥ?iծ"E????ǉd?G?g??>???	?@H?10%"??????fu?q?????B???????=a??:%??BF
6?Mۢk!?=?#?h
*???/??Nv?ؽ?E^&?????5"???.={?I%??IBРo?ǂG[??L#!x??ƴp+, ??R?	?NVr?0f????""?k{B??崜??/O?G?j{n?B}?l?D?0?!?ݴl????iV??m>?"?i?s?     