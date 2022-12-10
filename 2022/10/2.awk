BEGIN{X=1}     !$2{t++;c()} $2{t++;c();t++;c();X+=$2} END{for(i=0;i<=5;i++){
for(j=0;j<=39;j++){printf"%s",(l[i][j]?"#":".")}      printf "\n"}         }
function c(){p=((t-1)%40);r=int((t-1)/40);if(p==X-1||p==X||p==X+1)l[r][p]=1}
