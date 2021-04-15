n = read("input.txt");
m=n-1;

\\ écriture de n-1 sous la forme 2^l*m avec m impair
l=0;
while(m%2==0,l+=1;m/=2);

\\Le résultat obtenu est : l=3 et m=407636757865698604428550594767060422374899300864918027888630205586046708311880117221796445626309746336914631212972181482213962597567144800846260659834588481767178781035080708414331862943357812921609532891675819598525694552936547065634609712556249215542297738180201079761100677244958022951666525990680265

\\n a été déclaré composé par le test de Miller-Rabin donc il existe un entier a vérifiant 2<=a<=n-2 tel que:
\\a^m!=1 mod n, a^m!=-1 mod n et pour tout i allant de 1 à l-1, a^(m*(2^i)) != -1 mod n

\\Mais on nous informe que le premier tour du test a été passé sans que l'on puisse conclure sur la composition de n
\\ Donc il existe 2<=b<=n-2 tel que:
\\ b^m=+/-1 mod n ou b^(2m)=-1 mod n ou b^(4m)=-1 mod n



\\Cherchons un tel a
\\a=random(n-4)+2  nombre aléatoire dans [2,n-2]
\\test=0;
\\while(test==0,a=random(n-4)+2;a1=lift(Mod(a,n)^m);if( a1!=1 && a1!=n-1,a2=lift(Mod(a1,n)^(2));if(a2!=-1,a4=lift(Mod(a2,n)^2);if(a4!=-1,test=1););););
\\print("le temoin de Miller a vaut:", a);

\\ cherchons un "non témoin" b qui aurait pu faire passer le premier tour du test de Miller Rabin
\\b=random(n-4)+2  nombre aléatoire dans [2,n-2]


\\ On va donc chercher un 2<=b<=n-2 tel que b^(m*2k)!=+/-1 mod n et c = b^(m*2*(k+1))=1 mod n
\\ un tel b vérifie alors c-1=0 mod n soit (b^(m*2k))^2-1=0 mod n
\\ Ainsi on a (b^(m*2k)+1)(b^(m*2k)-1)=0 mod n
\\ Or on a vérifier juste avant que b^(m*2k)!=+/-1 donc aucun des deux facteurs b^(m*2k)+1 et b^(m*2k)-1 n'est un multiple de n
\\ (Autrement dit, le produit des deux est un multiple de n, alors qu'aucun des deux n'est un multiple de n, et donc ils contiennent tous les deux des diviseurs de n dans leur décomposition.)

\\ Ainsi pgcd(n,b^(m*2k)-1) nous donne un facteur non trivial de n

test=0;
while(test==0,b=random(n-4)+2;b=lift(Mod(b,n)^m);if( abs(c)!=1, for(i=1,l-1,c=lift(Mod(b,n)^2);if(c==1,test=1;break,b=c;if(b==n-1,break)))));
g=gcd(b-1,n);

\\on vérifie tout de même si la décomposition est bien un produit de deux nombres premiers, et que l'on renvoit bien le plus petit des deux.

if(isprime(g) && isprime(n/g) && g<(n/g),print(g),print(n/g));
