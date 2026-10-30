/// Banco de dados local de países.
/// Formato de cada linha: codigoISO,continente,facil(1/0),pt
/// As bandeiras são carregadas de https://flagcdn.com/w640/<codigo>.png
const String countriesRaw = '''
za,africa,1,África do Sul
eg,africa,1,Egito
ng,africa,1,Nigéria
ke,africa,0,Quênia
ma,africa,1,Marrocos
dz,africa,0,Argélia
et,africa,0,Etiópia
gh,africa,0,Gana
sn,africa,0,Senegal
tn,africa,0,Tunísia
ao,africa,1,Angola
mz,africa,1,Moçambique
cm,africa,0,Camarões
ci,africa,0,Costa do Marfim
tz,africa,0,Tanzânia
ug,africa,0,Uganda
zw,africa,0,Zimbábue
na,africa,0,Namíbia
mg,africa,0,Madagascar
ly,africa,0,Líbia
cv,africa,1,Cabo Verde
bw,africa,0,Botsuana
br,america,1,Brasil
ar,america,1,Argentina
us,america,1,Estados Unidos
ca,america,1,Canadá
mx,america,1,México
cl,america,1,Chile
co,america,1,Colômbia
pe,america,1,Peru
ve,america,0,Venezuela
uy,america,1,Uruguai
py,america,0,Paraguai
bo,america,0,Bolívia
ec,america,0,Equador
cu,america,1,Cuba
jm,america,0,Jamaica
pa,america,0,Panamá
cr,america,0,Costa Rica
do,america,0,República Dominicana
ht,america,0,Haiti
gt,america,0,Guatemala
hn,america,0,Honduras
ni,america,0,Nicarágua
sv,america,0,El Salvador
bs,america,0,Bahamas
tt,america,0,Trinidad e Tobago
gy,america,0,Guiana
sr,america,0,Suriname
jp,asia,1,Japão
cn,asia,1,China
in,asia,1,Índia
kr,asia,1,Coreia do Sul
kp,asia,0,Coreia do Norte
th,asia,1,Tailândia
vn,asia,0,Vietnã
id,asia,0,Indonésia
ph,asia,0,Filipinas
my,asia,0,Malásia
sg,asia,0,Singapura
tr,asia,1,Turquia
sa,asia,1,Arábia Saudita
ae,asia,0,Emirados Árabes Unidos
ir,asia,0,Irã
iq,asia,0,Iraque
il,asia,1,Israel
pk,asia,0,Paquistão
bd,asia,0,Bangladesh
np,asia,0,Nepal
lk,asia,0,Sri Lanka
kz,asia,0,Cazaquistão
uz,asia,0,Uzbequistão
af,asia,0,Afeganistão
mn,asia,0,Mongólia
qa,asia,0,Catar 
jo,asia,0,Jordânia
lb,asia,0,Líbano
kh,asia,0,Camboja
mm,asia,0,Mianmar
pt,europe,1,Portugal
es,europe,1,Espanha
fr,europe,1,França
de,europe,1,Alemanha
it,europe,1,Itália
gb,europe,1,Reino Unido
ie,europe,0,Irlanda
nl,europe,1,Países Baixos
be,europe,1,Bélgica
ch,europe,1,Suíça
at,europe,0,Áustria
se,europe,1,Suécia
no,europe,1,Noruega
dk,europe,0,Dinamarca
fi,europe,0,Finlândia
pl,europe,1,Polônia
cz,europe,0,Tchéquia
hu,europe,0,Hungria
gr,europe,1,Grécia
ro,europe,0,Romênia
bg,europe,0,Bulgária
ua,europe,1,Ucrânia
ru,europe,1,Rússia
hr,europe,0,Croácia
rs,europe,0,Sérvia
is,europe,0,Islândia
sk,europe,0,Eslováquia
si,europe,0,Eslovênia
lt,europe,0,Lituânia
lv,europe,0,Letônia
ee,europe,0,Estônia
al,europe,0,Albânia
ba,europe,0,Bósnia e Herzegovina
mt,europe,0,Malta
lu,europe,0,Luxemburgo
md,europe,0,Moldávia
au,oceania,1,Austrália
nz,oceania,1,Nova Zelândia
fj,oceania,0,Fiji
pg,oceania,0,Papua-Nova Guiné
ws,oceania,0,Samoa
to,oceania,0,Tonga
vu,oceania,0,Vanuatu  
sb,oceania,0,Ilhas Salomão
ki,oceania,0,Quiribati
nr,oceania,0,Nauru
tv,oceania,0,Tuvalu
''';
