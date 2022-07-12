/********************************* 
 * 대량정제 퍼블용 JS
 * - DHTMLX v.7.1.4
 * - BOOTSTRAP v4.0.0
 * - HTML 컴퍼넌트, DHTML위젯(GRID, LIST, FORM 등)  
 
 ※ 참고
 * 레이아웃, GRID 등 ID 값 퍼블/개발 동일하게 사용할 것을 권장합니다. 
 * ID 변경될 경우, 공유해주세요. (해당 ID에 맞게 css/js 사용되고 있습니다)
 * data 목록은 가짜데이터 입니다. (퍼블용)
 * collapse 되는 영역은 위젯, 그리드 등 attach 했습니다.
 * collapse 되지 않는 영역은 일부 HTML 컴퍼넌트, 위젯 혼용했습니다.
*********************************/

/********************************* 
 * 2022.02.11 : SR#51192 : 통합검색, 3COL 페이지
*********************************/

// 원부 가짜 데이터
var grid3_data = [
    {"gco3_img": "","gco3_make": "[불명]", "gco3_brand": "미쟝센", "gco3_name":"[미생성 원부]","gco3_cnt": "157", "nmaking": true},
    {"gco3_img": "http://image.enuri.info/webimage_300/9533000000/9533000000/9533002157.jpg", "gco3_make": "아모레퍼시픽", "gco3_brand": "미쟝센", "gco3_name":"스칼프 케어 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "gco3_make": "애경", "gco3_brand": "려", "gco3_name":"데미지 케어 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "gco3_make": "LG생활건강", "gco3_brand": "댄트롤", "gco3_name":"스칼프 케어 그린티 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "gco3_make": "한국P&G", "gco3_brand": "이니스프리", "gco3_name":"퍼펙트 세럼 샴푸 오리지널","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "gco3_make": "쿤달", "gco3_brand": "비타민", "gco3_name":"퍼펙트 세럼 스타일링 샴푸","gco3_cnt": "55", "similarMd": true},
    {"gco3_img": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "gco3_make": "닥터포헤어", "gco3_brand": "아모레퍼시픽", "gco3_name":"퍼펙트 세럼 샴푸 슈퍼리치","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "gco3_make": "유니레버", "gco3_brand": "프레시팝", "gco3_name":"에이징케어 파워베리 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "gco3_make": "아모스프로페셔널", "gco3_brand": "프리메라", "gco3_name":"데미지 케어 로즈프로틴 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "gco3_make": "명진인터내셔널", "gco3_brand": "아리따움",    "gco3_name":"헤어테라미 모이스처 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "gco3_make": "헤어플러스", "gco3_brand": "해피바스",    "gco3_name":"퍼펙트 세럼 미셀라 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "gco3_make": "닥터볼프", "gco3_brand": "에뛰드하우스",    "gco3_name":"체리블라썸 퍼퓸샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "gco3_make": "아로마티카", "gco3_brand": "미쟝센",    "gco3_name":"화이트머스크 퍼퓸샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "gco3_make": "러쉬", "gco3_brand": "려",    "gco3_name":"살롱 플러스 클리닉 10 손상모발","gco3_cnt": "55", "similarMd": true},
    {"gco3_img": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "gco3_make": "로레알", "gco3_brand": "댄트롤",    "gco3_name":"페어앤프리지아 퍼퓸 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "gco3_make": "두리화장품", "gco3_brand": "이니스프리",    "gco3_name":"살롱 플러스 클리닉 10 극손상모발용 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "gco3_make": "피에르파브르", "gco3_brand": "비타민",    "gco3_name":"슈퍼 보태니컬 리페어 릴렉싱 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "gco3_make": "부케가르니", "gco3_brand": "아모레퍼시픽",    "gco3_name":"에이징케어 콜라겐 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "gco3_make": "웰코스", "gco3_brand": "프레시팝",    "gco3_name":"그린데이지 퍼퓸 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10631200000/10631210000/10631219526.jpg", "gco3_make": "솔레오코스메틱", "gco3_brand": "프리메라",    "gco3_name":"스무스&실키 모이스처 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4688700000/4688790000/4688791914", "gco3_make": "아베다", "gco3_brand": "아리따움",    "gco3_name":"헤어테라피 샤이닝 모이스처 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8840900000/8840910000/8840910396.jpg", "gco3_make": "코스모코스", "gco3_brand": "해피바스",    "gco3_name":"살롱 플러스 클리닉 10 건조모발용 샴푸","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8473500000/8473500000/8473503520.jpg", "gco3_make": "코리아나화장품", "gco3_brand": "에뛰드하우스",    "gco3_name":"리본드 프로틴 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7163400000/7163480000/7163484250.jpg", "gco3_make": "노린스", "gco3_brand": "미쟝센",    "gco3_name":"5.5 프로틴 약산성 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7631200000/7631230000/7631230907", "gco3_make": "아모스", "gco3_brand": "려",    "gco3_name":"풀&글래머러스 볼륨 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/2229100000/2229130000/2229132621.jpg", "gco3_make": "세화피앤씨", "gco3_brand": "댄트롤",    "gco3_name":"안티에이징 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8939500000/8939580000/8939583209.jpg", "gco3_make": "토종식품", "gco3_brand": "이니스프리",    "gco3_name":"5.5 콜라겐 약산성 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5358600000/5358650000/5358653398.jpg", "gco3_make": "헨켈", "gco3_brand": "비타민",    "gco3_name":"아로마 에센셜 릴랙싱 샴푸 로터스&라벤더","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5455800000/5455800000/5455807674", "gco3_make": "다비네스", "gco3_brand": "아모레퍼시픽",    "gco3_name":"헬시&스트롱 리페어 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4572900000/4572930000/4572935120.jpg", "gco3_make": "폴미첼", "gco3_brand": "프레시팝",    "gco3_name":"데미지 케어 케라틴 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10229500000/10229550000/10229555748.jpg", "gco3_make": "피토", "gco3_brand": "프리메라",    "gco3_name":"펄 샤이닝 모이스처 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5038100000/5038120000/5038125404.jpg", "gco3_make": "시세이도", "gco3_brand": "아리따움",    "gco3_name":"아로마 에센셜 리프레싱 샴푸 오렌지플라워&베르가못","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/2531200000/2531240000/2531245239.jpg", "gco3_make": "수안향장", "gco3_brand": "해피바스",    "gco3_name":"퍼펙트 리페어 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5037900000/5037950000/5037950877.jpg", "gco3_make": "니옥신", "gco3_brand": "에뛰드하우스",    "gco3_name":"아로마 에센셜리바이탈라이징 샴푸 자스민&로즈마리","gco3_cnt": "55"},
    {"gco3_img": "http://photo3.enuri.info/data/images/service/img_300/11357000/11357074.jpg", "gco3_make": "제이코리아", "gco3_brand": "미쟝센",    "gco3_name":"쿨링 케어 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6580800000/6580870000/6580871736.jpg", "gco3_make": "아이덴", "gco3_brand": "려",    "gco3_name":"데미지 케어 샴푸 일회용","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4371900000/4371910000/4371913345.jpg", "gco3_make": "더바디샵", "gco3_brand": "댄트롤",    "gco3_name":"슈퍼 보태니컬 모이스처&리프레쉬 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7651600000/7651640000/7651646859.jpg", "gco3_make": "세바메드", "gco3_brand": "이니스프리",    "gco3_name":"슈퍼 보태니컬 볼륨 리바이탈라이징 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://photo3.enuri.info/data/images/service/img_300/11164000/11164870.jpg", "gco3_make": "엠코스메틱", "gco3_brand": "비타민",    "gco3_name":"샤이닝 케어 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/3864600000/3864610000/3864616559.jpg", "gco3_make": "네이처리퍼블릭", "gco3_brand": "아모레퍼시픽",    "gco3_name":"슈퍼 보태니컬 볼륨&리바이탈라이징 500ml 샴푸2+린스","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4420700000/4420700000/4420708294.jpg", "gco3_make": "라우쉬", "gco3_brand": "프레시팝",    "gco3_name":"스칼프 케어 마일드 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5619200000/5619250000/5619250929.jpg", "gco3_make": "밀본", "gco3_brand": "프리메라",    "gco3_name":"스파클링 선샤인 퍼퓸샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6610600000/6610640000/6610646969.jpg", "gco3_make": "파머스", "gco3_brand": "아리따움",    "gco3_name":"시어버터 5% 화이트머스크 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "gco3_make": "아발론오가닉스", "gco3_brand": "해피바스",    "gco3_name":"데미지 케어 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "gco3_make": "존슨앤존슨", "gco3_brand": "에뛰드하우스",    "gco3_name":"스칼프 케어 그린티 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "gco3_make": "다바찌", "gco3_brand": "미쟝센",    "gco3_name":"퍼펙트 세럼 샴푸 오리지널","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "gco3_make": "바론", "gco3_brand": "려",    "gco3_name":"퍼펙트 세럼 스타일링 샴푸","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "gco3_make": "다슈", "gco3_brand": "댄트롤",    "gco3_name":"퍼펙트 세럼 샴푸 슈퍼리치","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "gco3_make": "일진화장품", "gco3_brand": "이니스프리",    "gco3_name":"에이징케어 파워베리 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "gco3_make": "웰라", "gco3_brand": "비타민",    "gco3_name":"데미지 케어 로즈프로틴 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "gco3_make": "데저트에센스", "gco3_brand": "아모레퍼시픽",    "gco3_name":"헤어테라미 모이스처 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "gco3_make": "라벨영", "gco3_brand": "프레시팝",    "gco3_name":"퍼펙트 세럼 미셀라 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "gco3_make": "록시땅", "gco3_brand": "프리메라",    "gco3_name":"체리블라썸 퍼퓸샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "gco3_make": "피엘코스메틱", "gco3_brand": "아리따움",    "gco3_name":"화이트머스크 퍼퓸샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "gco3_make": "하나마이", "gco3_brand": "해피바스",    "gco3_name":"살롱 플러스 클리닉 10 손상모발","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "gco3_make": "모로칸오일", "gco3_brand": "에뛰드하우스",    "gco3_name":"페어앤프리지아 퍼퓸 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "gco3_make": "알터에고", "gco3_brand": "미쟝센",    "gco3_name":"살롱 플러스 클리닉 10 극손상모발용 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "gco3_make": "비더살롱", "gco3_brand": "려",    "gco3_name":"슈퍼 보태니컬 리페어 릴렉싱 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "gco3_make": "무코타", "gco3_brand": "댄트롤",    "gco3_name":"에이징케어 콜라겐 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "gco3_make": "제이숲", "gco3_brand": "이니스프리",    "gco3_name":"그린데이지 퍼퓸 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10631200000/10631210000/10631219526.jpg", "gco3_make": "르퀼라야", "gco3_brand": "비타민",    "gco3_name":"스무스&실키 모이스처 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4688700000/4688790000/4688791914", "gco3_make": "앙방", "gco3_brand": "아모레퍼시픽",    "gco3_name":"헤어테라피 샤이닝 모이스처 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8840900000/8840910000/8840910396.jpg", "gco3_make": "순수연구소", "gco3_brand": "프레시팝",    "gco3_name":"살롱 플러스 클리닉 10 건조모발용 샴푸","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8473500000/8473500000/8473503520.jpg", "gco3_make": "피토페시아", "gco3_brand": "프리메라",    "gco3_name":"리본드 프로틴 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7163400000/7163480000/7163484250.jpg", "gco3_make": "서울화장품", "gco3_brand": "아리따움",    "gco3_name":"5.5 프로틴 약산성 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7631200000/7631230000/7631230907", "gco3_make": "더허브스토리", "gco3_brand": "해피바스",    "gco3_name":"풀&글래머러스 볼륨 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/2229100000/2229130000/2229132621.jpg", "gco3_make": "수앤", "gco3_brand": "에뛰드하우스",    "gco3_name":"안티에이징 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8939500000/8939580000/8939583209.jpg", "gco3_make": "위드보스", "gco3_brand": "미쟝센",    "gco3_name":"5.5 콜라겐 약산성 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5358600000/5358650000/5358653398.jpg", "gco3_make": "스킨젠", "gco3_brand": "려",    "gco3_name":"아로마 에센셜 릴랙싱 샴푸 로터스&라벤더","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5455800000/5455800000/5455807674", "gco3_make": "존프리다", "gco3_brand": "댄트롤",    "gco3_name":"헬시&스트롱 리페어 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4572900000/4572930000/4572935120.jpg", "gco3_make": "빅그린", "gco3_brand": "이니스프리",    "gco3_name":"데미지 케어 케라틴 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10229500000/10229550000/10229555748.jpg", "gco3_make": "아하바", "gco3_brand": "비타민",    "gco3_name":"펄 샤이닝 모이스처 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5038100000/5038120000/5038125404.jpg", "gco3_make": "코랩", "gco3_brand": "아모레퍼시픽",    "gco3_name":"아로마 에센셜 리프레싱 샴푸 오렌지플라워&베르가못","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/2531200000/2531240000/2531245239.jpg", "gco3_make": "암웨이", "gco3_brand": "프레시팝",    "gco3_name":"퍼펙트 리페어 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5037900000/5037950000/5037950877.jpg", "gco3_make": "미라화장품", "gco3_brand": "프리메라",    "gco3_name":"아로마 에센셜리바이탈라이징 샴푸 자스민&로즈마리","gco3_cnt": "55"},
    {"gco3_img": "http://photo3.enuri.info/data/images/service/img_300/11357000/11357074.jpg", "gco3_make": "지오바니", "gco3_brand": "아리따움",    "gco3_name":"쿨링 케어 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6580800000/6580870000/6580871736.jpg", "gco3_make": "리즈케이", "gco3_brand": "해피바스",    "gco3_name":"데미지 케어 샴푸 일회용","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4371900000/4371910000/4371913345.jpg", "gco3_make": "모나리자화장품", "gco3_brand": "에뛰드하우스",    "gco3_name":"슈퍼 보태니컬 모이스처&리프레쉬 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7651600000/7651640000/7651646859.jpg", "gco3_make": "에바스", "gco3_brand": "미쟝센",    "gco3_name":"슈퍼 보태니컬 볼륨 리바이탈라이징 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://photo3.enuri.info/data/images/service/img_300/11164000/11164870.jpg", "gco3_make": "아름다운화장품", "gco3_brand": "려",    "gco3_name":"샤이닝 케어 샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/3864600000/3864610000/3864616559.jpg", "gco3_make": "에버미라클", "gco3_brand": "댄트롤",    "gco3_name":"슈퍼 보태니컬 볼륨&리바이탈라이징 500ml 샴푸2+린스","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4420700000/4420700000/4420708294.jpg", "gco3_make": "어헤즈", "gco3_brand": "이니스프리",    "gco3_name":"스칼프 케어 마일드 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5619200000/5619250000/5619250929.jpg", "gco3_make": "말콤", "gco3_brand": "비타민",    "gco3_name":"스파클링 선샤인 퍼퓸샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6610600000/6610640000/6610646969.jpg", "gco3_make": "동국제약", "gco3_brand": "아모레퍼시픽",    "gco3_name":"시어버터 5% 화이트머스크 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "gco3_make": "닥터큐", "gco3_brand": "프레시팝",    "gco3_name":"데미지 케어 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "gco3_make": "포고니아", "gco3_brand": "프리메라",    "gco3_name":"스칼프 케어 그린티 샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "gco3_make": "로고니아", "gco3_brand": "아리따움",    "gco3_name":"퍼펙트 세럼 샴푸 오리지널","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "gco3_make": "아쥬반", "gco3_brand": "해피바스",    "gco3_name":"퍼펙트 세럼 스타일링 샴푸","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "gco3_make": "클레보스", "gco3_brand": "에뛰드하우스",    "gco3_name":"퍼펙트 세럼 샴푸 슈퍼리치","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "gco3_make": "비어랩", "gco3_brand": "미쟝센",    "gco3_name":"에이징케어 파워베리 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "gco3_make": "우테크람", "gco3_brand": "려",    "gco3_name":"데미지 케어 로즈프로틴 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "gco3_make": "가인화장품", "gco3_brand": "댄트롤",    "gco3_name":"헤어테라미 모이스처 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "gco3_make": "뉴스킨", "gco3_brand": "이니스프리",    "gco3_name":"퍼펙트 세럼 미셀라 샴푸","gco3_cnt": "121"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "gco3_make": "KBH한국생활건강", "gco3_brand": "비타민",    "gco3_name":"체리블라썸 퍼퓸샴푸","gco3_cnt": "100"},
    {"gco3_img": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "gco3_make": "트리트룸", "gco3_brand": "아모레퍼시픽",    "gco3_name":"화이트머스크 퍼퓸샴푸","gco3_cnt": "81"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "gco3_make": "더마클라센", "gco3_brand": "프레시팝",    "gco3_name":"살롱 플러스 클리닉 10 손상모발","gco3_cnt": "55"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "gco3_make": "아미니", "gco3_brand": "프리메라",    "gco3_name":"페어앤프리지아 퍼퓸 샴푸","gco3_cnt": "1"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "gco3_make": "에이블C", "gco3_brand": "아리따움",    "gco3_name":"살롱 플러스 클리닉 10 극손상모발용 샴푸","gco3_cnt": "3"},
    {"gco3_img": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "gco3_make": "수앤코리아", "gco3_brand": "해피바스",    "gco3_name":"슈퍼 보태니컬 리페어 릴렉싱 샴푸","gco3_cnt": "234"},
    {"gco3_img": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "gco3_make": "큐어실드", "gco3_brand": "에뛰드하우스",    "gco3_name":"에이징케어 콜라겐 샴푸","gco3_cnt": "157"},
    {"gco3_img": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "gco3_make": "라르슈포제", "gco3_brand": "미쟝센",    "gco3_name":"그린데이지 퍼퓸 샴푸","gco3_cnt": "121"},
];
// 그리드3 넘버링
var grid3len = grid3_data.length;
for(var i = 0; i < grid3len; i++) {
    var row = grid3_data[i];
    row.idx = i+1;
}
// 조건 가짜 데이터
var grid4_data = [
    {"gcol1": "1L","gcol2": "1개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "2개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "3개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "4개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "5개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "6개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "7개","gcol3": "0"}, 
    {"gcol1": "1L","gcol2": "481개","gcol3": "0"}, 
    {"gcol1": "530ml","gcol2": "1개","gcol3": "0"}, 
    {"gcol1": "530ml","gcol2": "2개","gcol3": "0"}, 
    {"gcol1": "530ml","gcol2": "3개","gcol3": "0"}, 
    {"gcol1": "530ml","gcol2": "12개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "1개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "2개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "3개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "4개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "5개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "6개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "7개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "8개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "9개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "10개","gcol3": "0"}, 
    {"gcol1": "680ml","gcol2": "12개","gcol3": "0"}, 

]
// 가격리스트(EP) 가짜 데이터
var eslist = [
    {"pl_no": 9125260161, "imgurl": "http://image.enuri.info/webimage_300/9533000000/9533000000/9533002157.jpg", "shopname": "쇼핑몰명 노출", "goodsnm": "[삼성카드]나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "1,238,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=4828080850&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 9125370004, "imgurl": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "234,238,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=5025867878&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 8506035857, "imgurl": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "239,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=2046241393&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7716796560, "imgurl": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=1957914737&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7972212437, "imgurl": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "shopname": "쇼핑몰명", "goodsnm": "[NH카드 7% 할인]나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,210", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.g9.co.kr/Display/VIP/Index/1957914737?jaehuid=200006435", "matchYn": false},
    {"pl_no": 7719433575, "imgurl": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4505627456&lptag=P4505627456&itemId=5414295739&vendorItemId=72736989083", "matchYn": true},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": true},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": true},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/10631200000/10631210000/10631219526.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/4688700000/4688790000/4688791914", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": true},
    {"pl_no": 9125260161, "imgurl": "http://image.enuri.info/webimage_300/8840900000/8840910000/8840910396.jpg", "shopname": "쇼핑몰명", "goodsnm": "[삼성카드]나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=4828080850&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 9125370004, "imgurl": "http://image.enuri.info/webimage_300/8473500000/8473500000/8473503520.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=5025867878&coupon_srl=2728990", "matchYn": true},
    {"pl_no": 8506035857, "imgurl": "http://image.enuri.info/webimage_300/7163400000/7163480000/7163484250.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=2046241393&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7716796560, "imgurl": "http://image.enuri.info/webimage_300/7631200000/7631230000/7631230907", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=1957914737&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7972212437, "imgurl": "http://image.enuri.info/webimage_300/2229100000/2229130000/2229132621.jpg", "shopname": "쇼핑몰명", "goodsnm": "[NH카드 7% 할인]나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,210", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.g9.co.kr/Display/VIP/Index/1957914737?jaehuid=200006435", "matchYn": false},
    {"pl_no": 7719433575, "imgurl": "http://image.enuri.info/webimage_300/8939500000/8939580000/8939583209.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4505627456&lptag=P4505627456&itemId=5414295739&vendorItemId=72736989083", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/5358600000/5358650000/5358653398.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/5455800000/5455800000/5455807674", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": true},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/4572900000/4572930000/4572935120.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/10229500000/10229550000/10229555748.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/5038100000/5038120000/5038125404.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/2531200000/2531240000/2531245239.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/5037900000/5037950000/5037950877.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://photo3.enuri.info/data/images/service/img_300/11357000/11357074.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/6580800000/6580870000/6580871736.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/4371900000/4371910000/4371913345.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/7651600000/7651640000/7651646859.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://photo3.enuri.info/data/images/service/img_300/11164000/11164870.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": true},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/3864600000/3864610000/3864616559.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/4420700000/4420700000/4420708294.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 9125260161, "imgurl": "http://image.enuri.info/webimage_300/5619200000/5619250000/5619250929.jpg", "shopname": "쇼핑몰명", "goodsnm": "[삼성카드]나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=4828080850&coupon_srl=2728990", "matchYn": true},
    {"pl_no": 9125370004, "imgurl": "http://image.enuri.info/webimage_300/6610600000/6610640000/6610646969.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=5025867878&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 8506035857, "imgurl": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=2046241393&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7716796560, "imgurl": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=1957914737&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7972212437, "imgurl": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "shopname": "쇼핑몰명", "goodsnm": "[NH카드 7% 할인]나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,210", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.g9.co.kr/Display/VIP/Index/1957914737?jaehuid=200006435", "matchYn": false},
    {"pl_no": 7719433575, "imgurl": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4505627456&lptag=P4505627456&itemId=5414295739&vendorItemId=72736989083", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": true},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": true},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/10631200000/10631210000/10631219526.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 9125260161, "imgurl": "http://image.enuri.info/webimage_300/4688700000/4688790000/4688791914", "shopname": "쇼핑몰명", "goodsnm": "[삼성카드]나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=4828080850&coupon_srl=2728990", "matchYn": true},
    {"pl_no": 9125370004, "imgurl": "http://image.enuri.info/webimage_300/8840900000/8840910000/8840910396.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=5025867878&coupon_srl=2728990", "matchYn": true},
    {"pl_no": 8506035857, "imgurl": "http://image.enuri.info/webimage_300/8473500000/8473500000/8473503520.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=2046241393&GoodsSale=Y&jaehuid=200002673", "matchYn": true},
    {"pl_no": 7716796560, "imgurl": "http://image.enuri.info/webimage_300/7163400000/7163480000/7163484250.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=1957914737&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7972212437, "imgurl": "http://image.enuri.info/webimage_300/7631200000/7631230000/7631230907", "shopname": "쇼핑몰명", "goodsnm": "[NH카드 7% 할인]나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,210", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.g9.co.kr/Display/VIP/Index/1957914737?jaehuid=200006435", "matchYn": false},
    {"pl_no": 7719433575, "imgurl": "http://image.enuri.info/webimage_300/2229100000/2229130000/2229132621.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4505627456&lptag=P4505627456&itemId=5414295739&vendorItemId=72736989083", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/8939500000/8939580000/8939583209.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/5358600000/5358650000/5358653398.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/5455800000/5455800000/5455807674", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/4572900000/4572930000/4572935120.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": true},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/10229500000/10229550000/10229555748.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/5038100000/5038120000/5038125404.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": true},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/2531200000/2531240000/2531245239.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/5037900000/5037950000/5037950877.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://photo3.enuri.info/data/images/service/img_300/11357000/11357074.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/6580800000/6580870000/6580871736.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/4371900000/4371910000/4371913345.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/7651600000/7651640000/7651646859.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://photo3.enuri.info/data/images/service/img_300/11164000/11164870.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/3864600000/3864610000/3864616559.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 9125260161, "imgurl": "http://image.enuri.info/webimage_300/4420700000/4420700000/4420708294.jpg", "shopname": "쇼핑몰명", "goodsnm": "[삼성카드]나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=4828080850&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 9125370004, "imgurl": "http://image.enuri.info/webimage_300/5619200000/5619250000/5619250929.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m 1팩 - 나무야나무야", "price": "8,520", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.tmon.co.kr/entry/?jp=80024&ln=205013&p_no=5025867878&coupon_srl=2728990", "matchYn": false},
    {"pl_no": 8506035857, "imgurl": "http://image.enuri.info/webimage_300/6610600000/6610640000/6610646969.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=2046241393&GoodsSale=Y&jaehuid=200002673", "matchYn": false},
    {"pl_no": 7716796560, "imgurl": "http://image.enuri.info/webimage_300/3828500000/3828590000/3828594408.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,000", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.gmarket.co.kr/challenge/neo_jaehu/jaehu_goods_gate.asp?goodscode=1957914737&GoodsSale=Y&jaehuid=200002673", "matchYn": true},
    {"pl_no": 7972212437, "imgurl": "http://image.enuri.info/webimage_300/8978000000/8978040000/8978041284.jpg", "shopname": "쇼핑몰명", "goodsnm": "[NH카드 7% 할인]나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,210", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://www.g9.co.kr/Display/VIP/Index/1957914737?jaehuid=200006435", "matchYn": false},
    {"pl_no": 7719433575, "imgurl": "http://image.enuri.info/webimage_300/7621000000/7621070000/7621079541.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4505627456&lptag=P4505627456&itemId=5414295739&vendorItemId=72736989083", "matchYn": true},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/7169500000/7169540000/7169544203.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/5431700000/5431780000/5431780716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/6972900000/6972910000/6972913054.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/9622000000/9622040000/9622045486.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/10462800000/10462880000/10462886671.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/8201800000/8201840000/8201848704.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false},
    {"pl_no": 8741964188, "imgurl": "http://image.enuri.info/webimage_300/8286700000/8286770000/8286776059.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 나무야 나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "9,900", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "http://pd.auction.co.kr/pd_redirect.asp?itemno=C313249249&pc=589", "matchYn": false},
    {"pl_no": 7731350781, "imgurl": "http://image.enuri.info/webimage_300/4394900000/4394990000/4394999276", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,600", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511105947&lptag=P4511105947&itemId=5426578221&vendorItemId=72726474090", "matchYn": false},
    {"pl_no": 7354495399, "imgurl": "http://image.enuri.info/webimage_300/8897300000/8897330000/8897330949.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=2258724710&lptag=P2258724710&itemId=3868134922&vendorItemId=71852863740", "matchYn": true},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/9163500000/9163540000/9163540716.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/8985500000/8985570000/8985572647.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 7731329206, "imgurl": "http://image.enuri.info/webimage_300/10228500000/10228590000/10228593298", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511115041&lptag=P4511115041&itemId=5426602276&vendorItemId=72726497586", "matchYn": false},
    {"pl_no": 7731353879, "imgurl": "http://image.enuri.info/webimage_300/9366900000/9366930000/9366936493.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=4511122149&lptag=P4511122149&itemId=5426622335&vendorItemId=72726516762", "matchYn": false},
    {"pl_no": 6532986870, "imgurl": "http://image.enuri.info/webimage_300/8355800000/8355870000/8355870293.jpg", "shopname": "쇼핑몰명", "goodsnm": "나무야나무야 도톰한 3겹 깨끗한 무향 롤화장지 27m", "price": "17,800", "cond02": "27m", "cond03": "", "cond04": "1팩", "score": 0, "modelno": 0, "brnd": "나무야나무야", "url": "https://link.coupang.com/re/PCSENURIPCSDP?pageKey=1731310866&lptag=P1731310866&itemId=2947076155&vendorItemId=70935643852", "matchYn": false}
];
// 가격리스트(EP) 넘버링
var eslen = eslist.length;
for (var i = 0; i < eslen; i++) {
    var row = eslist[i];
    row.idx = i+1;
}

// 헤더 컴퍼넌트 
var headerComponent = "";

    headerComponent += "<header id=\"header\">";
    headerComponent += "  <h1>NEW MP</h1>";
    headerComponent += "  <div class=\"admin_control\">";
    headerComponent += "      <ul class=\"exlink_list\">";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"CM 주요 관리 지표\">CM 주요 관리 지표</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"경쟁사 모니터링\">경쟁사 모니터링</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"핵심 속성 입력/점검\">핵심 속성 입력/점검</a></li>";
    headerComponent += "        <li><a href=\"#\" target=\"_blank\" title=\"제조사[불명] 현황\">제조사[불명] 현황</a></li>";
    headerComponent += "        <li class=\"has-sub\"><button title=\"연관상품(소모품)\">연관상품(소모품)</button>";
    headerComponent += "            <div class=\"exlink_sub\">";
    headerComponent += "                <ul>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">TV</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">홈시어터</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">프로젝터/스크린</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">홈시어터/HiFi</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">영상가전 액세서리</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">주방가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">생활가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">계절가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">건강가전</a></li>";
    headerComponent += "                    <li><a href=\"./related_products.html\" target=\"_blank\">미용/욕실가전</a></li>";
    headerComponent += "                </ul>";
    headerComponent += "            </div>";
    headerComponent += "        </li>";
    headerComponent += "      </ul>";
    headerComponent += "      <p class=\"user_log\">로그인정보 <span>2021.11.12 10:27:10</span></p>";
    headerComponent += "  </div>";
    headerComponent += "</header>";

// 페이지 정보 컴퍼넌트
var pageUtilComponent = "";

    pageUtilComponent += "<div class=\"pageutil\">";
    pageUtilComponent += "    <div class=\"container-fluid\">";
    pageUtilComponent += "        <div class=\"row\">";
    pageUtilComponent += "            <div class=\"col-12\">";

    // ************************* 220211 : SR#51192 : 삭제
    //pageUtilComponent += "                <div class=\"cateshow\">";
    //pageUtilComponent += "                  <ol class=\"cate_breadcrumb\">";
    //pageUtilComponent += "                      <li><span>생활,취미</span></li>";
    //pageUtilComponent += "                      <li><span>생활용품</span></li>";
    //pageUtilComponent += "                  </ol>";
    //pageUtilComponent += "                  <div class=\"btn-group\">";
    //pageUtilComponent += "                      <button type=\"button\" class=\"btn btn_show\">열기</button>";
    //pageUtilComponent += "                  </div>";
    //pageUtilComponent += "                </div>";

    pageUtilComponent += "                <div class=\"datainfo\">";
    pageUtilComponent += "                  <div class=\"datainfo_inner\">";
    pageUtilComponent += "                    <dl>";
    pageUtilComponent += "                        <dt>GMV 달성율:</dt>";
    pageUtilComponent += "                        <dd><p class=\"tx tx-up\">81.75%</p></dd>";
    pageUtilComponent += "                        <dd><p>YOY</p><p class=\"tx tx-up\">103%</p></dd>";
    pageUtilComponent += "                    </dl>";

    pageUtilComponent += "                    <dl>";
    pageUtilComponent += "                        <dt>생산량 달성율:</dt>";
    pageUtilComponent += "                        <dd><p>추가</p><p class=\"tx tx-down\">145%</p></dd>";
    pageUtilComponent += "                        <dd><p>매칭</p><p class=\"tx tx-down\">560%</p></dd>";
    pageUtilComponent += "                    </dl>";
    pageUtilComponent += "                  </div>";
    pageUtilComponent += "                </div>";
    pageUtilComponent += "            </div>";
    pageUtilComponent += "        </div>";
    pageUtilComponent += "    </div>";
    pageUtilComponent += "</div>";

// 제조사 컴퍼넌트
var makeComponent = "";

    makeComponent += "<div class=\"control__box\">";
    makeComponent += "  <div class=\"container\">";
    makeComponent += "      <div class=\"row row-foot\">";
    makeComponent += "          <div class=\"col-12\">";
    makeComponent += "              <div class=\"input-group\">";
    makeComponent += "                  <input type=\"text\" class=\"form-control ipt-txt--srch\" placeholder=\"검색어를 입력하세요.\" aria-label=\"\" aria-describedby=\"basic-addon2\">";
    makeComponent += "                  <div class=\"input-group-append\">";
    makeComponent += "                      <button class=\"btn btn-submit\" type=\"button\"><i class=\"bi bi-search\"></i></button>";
    makeComponent += "                  </div>";
    makeComponent += "              </div>";
    makeComponent += "          </div>";
    makeComponent += "      </div>";    
    makeComponent += "  </div>";    
    makeComponent += "</div>";

// 브랜드 컴퍼넌트
var brandComponent = "";

    brandComponent += "<div class=\"control__box\">";
    brandComponent += " <div class=\"container\">";
    brandComponent += "     <div class=\"row row-foot\">";
    brandComponent += "         <div class=\"col-12\">";
    brandComponent += "             <div class=\"input-group\">";
    brandComponent += "                 <input type=\"text\" class=\"form-control ipt-txt--srch\" placeholder=\"검색어를 입력하세요.\" aria-label=\"\" aria-describedby=\"basic-addon2\">";
    brandComponent += "                 <button class=\"btn btn-submit\" type=\"button\"><i class=\"bi bi-search\"></i></button>";
    brandComponent += "             </div>";
    brandComponent += "         </div>";
    brandComponent += "     </div>";
    brandComponent += " </div>";
    brandComponent += "</div>";

// 원부 컴퍼넌트
var originComponent = "";

    originComponent += "<div class=\"control__box\">";
    originComponent += "    <div class=\"container\">";
    originComponent += "        <div class=\"row row-head\">";
    originComponent += "            <div class=\"col-4\">";
    originComponent += "                <div class=\"btn-group\">";
    originComponent += "                    <button type=\"button\" class=\"btn btn-sort\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><i class=\"bi bi-filter-left\" style=\"\"></i> 미매칭수순</button>";
    originComponent += "                    <div class=\"dropdown-menu\">";
    originComponent += "                        <a class=\"dropdown-item\" href=\"#\">미매칭수순</a>";
    originComponent += "                        <a class=\"dropdown-item\" href=\"#\">매칭수순</a>";
    originComponent += "                    </div>";
    originComponent += "                </div>";
    originComponent += "            </div>";
    originComponent += "            <div class=\"col-8\">";
    originComponent += "                <div class=\"btn-group btn-group--right\">";
    originComponent += "                    <button type=\"button\" class=\"btn btn-add\" onclick=\"$('#originEdit').fadeIn();\">추가</button>";
    originComponent += "                    <button type=\"button\" class=\"btn btn-modify\" onclick=\"$('#originEdit').fadeIn();\">변경</button>";
    originComponent += "                    <button type=\"button\" class=\"btn btn-save\" id=\"btnOriginDel\">삭제</button>";
    originComponent += "                </div>";
    originComponent += "            </div>";
    originComponent += "        </div>";
    originComponent += "    </div>";
    originComponent += "</div>";  

// 조건 컴퍼넌트
var termComponent = "";

    termComponent += "<div class=\"control__box\">";
    termComponent += "  <div class=\"container\">";
    termComponent += "      <div class=\"row row-head\">";
    termComponent += "          <div class=\"col-12\">";
    termComponent += "              <div class=\"btn-group btn-group--right\">";
    termComponent += "                  <button type=\"button\" class=\"btn btn-add\" onclick=\"$('#conditionEdit').fadeIn();\">추가</button>";
    termComponent += "                  <button type=\"button\" class=\"btn btn-modify\" onclick=\"$('#conditionEdit').fadeIn();\">변경</button>";
    termComponent += "              </div>";
    termComponent += "          </div>";
    termComponent += "      </div>";
    termComponent += "  </div>";
    termComponent += "</div>";

// 신규조건 컴퍼넌트
var srchNewComponent = "";

    srchNewComponent += "<div class=\"control__box control__box-newsr\">";
    srchNewComponent += "  <div class=\"container\">";
    srchNewComponent += "      <div class=\"row row-head\">";
    srchNewComponent += "          <div class=\"col-12\">";
    srchNewComponent += "              <div class=\"btn-group btn-group--fluid\">";
    srchNewComponent += "                  <button type=\"button\" class=\"btn btn-srch-full\">찾기</button>";
    srchNewComponent += "              </div>";
    srchNewComponent += "          </div>";
    srchNewComponent += "      </div>";
    srchNewComponent += "  </div>";
    srchNewComponent += "</div>";

// 상품 검색 영역 컴퍼넌트 
var prdcSrchComponent = "";

    prdcSrchComponent += "<div class=\"searchbar\">";
    prdcSrchComponent += "    <div class=\"container-fluid\">";
    prdcSrchComponent += "        <div class=\"row\">";
    prdcSrchComponent += "            <div class=\"col-12\">";
    prdcSrchComponent += "                <form>";
    prdcSrchComponent += "                <div class=\"srchbox\">";
    prdcSrchComponent += "                    <div class=\"dropdownbox\">";
    prdcSrchComponent += "                        <button type=\"button\" class=\"btn btn-srch-select dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">전체</button>";
    prdcSrchComponent += "                        <div class=\"dropdown-menu\">";
    prdcSrchComponent += "                            <a class=\"dropdown-item\" href=\"#\">전체</a>";
    prdcSrchComponent += "                            <a class=\"dropdown-item\" href=\"#\">카테고리내</a>";
    prdcSrchComponent += "                            <a class=\"dropdown-item\" href=\"#\">결과내</a>";
    prdcSrchComponent += "                        </div>";
    prdcSrchComponent += "                    </div>";    
    prdcSrchComponent += "                    <div class=\"input-group\">";
    prdcSrchComponent += "                        <input type=\"text\" class=\"form-control ipt-txt--srch\" placeholder=\"검색어를 입력하세요.\">";
    prdcSrchComponent += "                        <div class=\"input-group-append\">";
    prdcSrchComponent += "                            <button class=\"btn btn-submit\" type=\"submit\"><i class=\"bi bi-search\"></i></button>";
    prdcSrchComponent += "                        </div>";
    prdcSrchComponent += "                    </div>"; 
    prdcSrchComponent += "                </div>";
    prdcSrchComponent += "                </form>";
    prdcSrchComponent += "            </div>";
    prdcSrchComponent += "        </div>";
    prdcSrchComponent += "    </div>";
    prdcSrchComponent += "</div>";

// 매칭/미매칭 컴퍼넌트
var matchingComponent = "";

    matchingComponent += "<div class=\"control__box control__box--comp\">";
    matchingComponent += "    <div class=\"container-fluid\">";
    matchingComponent += "        <div class=\"row\">";
    matchingComponent += "            <div class=\"col-12\">";
    matchingComponent += "                <div class=\"prdc__info\">";
    matchingComponent += "                    <div class=\"thumb\" id=\"prdcThumb\"><img src=\"http://image.enuri.info/webimage_300/6285200000/6285280000/6285280423.jpg\" alt=\"\" /></div>";
    
    matchingComponent += "                    <div class=\"tx\">";
    matchingComponent += "                        <div class=\"tx_util\">";
    matchingComponent += "                            <div class=\"tx_unit\">";
    matchingComponent += "                                <a href=\"#\" class=\"tx_mnum\">모델번호 : 11577831</a>";
    matchingComponent += "                                <div class=\"tx_price\">";
    matchingComponent += "                                    <p class=\"tx_min\">최저가 : <em>44,440</em></p>";
    matchingComponent += "                                    <p class=\"tx_max\">최고가 : <em>12,620</em></p>";
    matchingComponent += "                                </div>";
    matchingComponent += "                            </div>";
    matchingComponent += "                            <div class=\"model_info\">";
    matchingComponent += "                                <ul>";
    matchingComponent += "                                  <li><p class=\"tx_dt\">제조사</p><p class=\"tx_dd\">한국P&amp;G</p></li>";
    matchingComponent += "                                  <li><p class=\"tx_dt\">브랜드</p><p class=\"tx_dd\">헤어레시피</p></li>";
    matchingComponent += "                                  <li><p class=\"tx_dt\">스칼프 케어 샴푸 1L 481개</p></li>";
    matchingComponent += "                                </ul>";
    matchingComponent += "                            </div>";
    // ************************* 220211 : SR#51192 : 옵션 전체보기 추가
    matchingComponent += "                            <div class=\"model_option\">";
    matchingComponent += "                                <button type=\"button\" id=\"btnOptionAll\" class=\"btn_all\">전체보기</button>";
    matchingComponent += "                                <ul>";
    matchingComponent += "                                  <li>용량: 900ml</li>";
    matchingComponent += "                                  <li>수량: 1개</li>";
    matchingComponent += "                                </ul>";
    matchingComponent += "                            </div>";
    matchingComponent += "                        </div>";
    matchingComponent += "                    </div>";
    matchingComponent += "                    <div class=\"attr_input\">";
    matchingComponent += "                        <button class=\"btn btn-attrin\" type=\"button\" data-target=\"./popup_productAttrAdmin.html\" data-pname=\"prdcAttributeAdmin\" onclick=\"popupOpen($(this).data('target'), $(this).data('pname'), 1180, 980)\">속성 입력</button>";
    matchingComponent += "                    </div>";
    matchingComponent += "                </div>";
    matchingComponent += "            </div>";
    matchingComponent += "        </div>";
    matchingComponent += "    </div>";
    matchingComponent += "</div>";

// 선택 상품 명 표시 영역
var modelNameBox = "";

    modelNameBox += "<div class=\"control__box control__box--modelnm\">";
    modelNameBox += "    <div class=\"container-fluid\">";
    modelNameBox += "        <div class=\"row\">";
    modelNameBox += "            <div class=\"col-12\">";   
    modelNameBox += "                <div class=\"input-group\">";
    modelNameBox += "                    <input type=\"text\" class=\"form-control ipt-txt--srch\" id=\"modelNameIn\" placeholder=\"\" readonly=\"readonly\">";
    modelNameBox += "                </div>"; 
    modelNameBox += "            </div>";
    modelNameBox += "        </div>";
    modelNameBox += "    </div>";
    modelNameBox += "</div>";

// 그리드/이미지 뷰타입 전환 버튼 
var viewTypeChange = "";

    viewTypeChange += "<div class=\"viewtype_change\">";
    viewTypeChange += "     <button type=\"button\" class=\"btn_type btn_type-grid is-on\" data-viewtype=\"gridTypeList\">그리드타입</button>";
    viewTypeChange += "     <button type=\"button\" class=\"btn_type btn_type-image\" data-viewtype=\"imageTypeList\">이미지타입</button>";
    viewTypeChange += "</div>"

// ************************* 220211 : SR#51192 : 상단>레이아웃 변경 버튼 및 윈도우 위젯
// 레이아웃 변경
var changeViewBtn = "";
    changeViewBtn += "<div class=\"change_view\">";
    changeViewBtn += "  <button class=\"btn_change\" onclick=\"dhxWindow.show()\">show</button>";
    changeViewBtn += "</div>";

// 레이아웃 위젯 HTML
var layChangeCont = "";
    layChangeCont += "<div class=\"lay_changeView\">";
    layChangeCont += "  <div class=\"sel_layout\">";
    layChangeCont += "      <ul>";
    layChangeCont += "          <li><button type=\"button\" class=\"btn_lay1\" data-layout=\"1\">레이아웃01</button></li>";
    layChangeCont += "          <li class=\"is-on\"><button type=\"button\" class=\"btn_lay2\" data-layout=\"2\">레이아웃02</button></li>";
    layChangeCont += "      </ul>";
    layChangeCont += "  </div>";
    layChangeCont += "  <div class=\"lay_foot\">";
    layChangeCont += "      <button type=\"button\" class=\"btn_excute\">열기</button>";
    layChangeCont += "      <button type=\"button\"onclick=\"dhxWindow.hide()\">닫기</button>";
    layChangeCont += "  </div>";
    layChangeCont += "</div>";

// 레이어 위젯
var dhxWindow = new dhx.Window({
    title: "화면 유형 설정",
    closable: false,
    css: "lay_changeview",
    html: layChangeCont
});

// 레이아웃 선택 
var loadSt = false; // 로딩 상태
var layoutNum = 1;
$(document).on("click", ".sel_layout>ul>li", function(){
    var _this = $(this);        
    
        _this.addClass("is-on").siblings("li").removeClass("is-on");
        layoutNum = _this.find("button").data("layout");
})
// 레이아웃 변경
$(document).on("click", ".lay_changeView .btn_excute", function(){
    dhxWindow.hide();

    $(".loader_box").fadeIn();
    setTimeout(function(){
        loadSt = true;
        if(loadSt){
            $(".loader_box").fadeOut();
    
            if(layoutNum === 1){
                //레이아웃1
                window.open("./index.html");
            }else if(layoutNum === 2){
                //레이아웃2
                window.location.href = "./index_srch.html"
            }
            loadSt = false;
        }
    }, 1000) // 임의속도
})

/*********************************
 * 각 COL 그리드/리스트 생성하여 attach 합니다.
*********************************/
var grid3, grid4, grid5, grid6; // 각 COL 그리드
var epViewContainer; // EP상품 뷰타입 컨테이너
var imageTypeList; // EP상품 이미지뷰 위젯 생성

// 원부 그리드 생성 
grid3 = new dhx.Grid(null, {
    columns: [
        { id: "idx", width: 40, header: [{text: "#", align:"center"}], align:"center",},
        { id: "gco3_img", width: 40, header: [{ text: "", align: "center" }], htmlEnable: true, tooltip: true, align: "center",
            template: function (text, row, col) { 
                return "<img src=\""+text+"\" alt=\"\" class=\"thumb\">"; 
            } 
        },
        { id: "gco3_make", width:120, header: [{ text: "제조사", align: "center"}], htmlEnable: true, gravity: 1.5,
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        { id: "gco3_brand", width:120, header: [{ text: "브랜드", align: "center"}], htmlEnable: true, gravity: 1.5,
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        { id: "gco3_name", width: 120, header: [{ text: "원부명", align: "center" }], align: "left", htmlEnable: true, 
            template: function (text, row, col) { 
                return "<p class=\"tx_tit\">"+text+"</p>"; 
            }  
        },
        { id: "gco3_cnt", width: 60, header: [{ text: "미매칭수", align: "center" }], align: "right" },
    ],
    rowCss: function(row){        
        if(row.nmaking) return "nmaking_row"; // 미생성 원부 행 클래스 추가
        else if(row.similarMd) return "similar_row"; // 유사모델 클래스 추가
        else return "";
    },
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth:true,
    //data: grid3_data,
    selection: "row",
    multiselection:false,
    keyNavigation: true, 
    resizable:true, 
    adjust: true,
    tooltip: false
});
// 조건 그리드 생성
grid4 = new dhx.Grid(null, {
    columns: [
        { id: "gcol1", header: [{ text: "용량", align: "center" }], align: "center", htmlEnable: true, gravity: 1.5,
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        // 220117 : 조건 그리드 미매칭 width :60  추가
        { id: "gcol2", width: 60, header: [{ text: "개", align: "center" }], align:"right" },
        { id: "gcol3", width: 60, header: [{ text: "미매칭수", align: "center" }], align:"right" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth:true,
    data: grid4_data,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    // 220117 : adjust 제거
    //adjust: true, 
    tooltip: false
});
// 신규조건 그리드 생성
grid5 = new dhx.Grid(null, {
    columns: [
        { id: "gcol1", header: [{ text: "용량", align: "center" }], align: "center", htmlEnable: true, gravity: 1.5,
            template: function (text, row, col) { 
                return "<p class=\"tx_tit_one\">"+text+"</p>"; 
            }, 
        },
        // 220117 : 조건 그리드 미매칭 width :60  추가
        { id: "gcol2", width: 60, header: [{ text: "개", align: "center" }], align:"right" },
        { id: "gcol3", width: 60, header: [{ text: "미매칭수", align: "center" }], align:"right" },
    ],
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth:true,
    data: grid4_data,
    selection: "row",
    multiselection:false,
    keyNavigation: true,
    resizable:true,
    // 220117 : adjust 제거
    //adjust: true,
    tooltip: false
});
// EP상품 그리드 생성
grid6 = new dhx.Grid(null, {
    columns: [
        { width: 40, id: "idx", header: [{text: "#", align:"center"}], resizable:false, align:"center",},
        { width: 50, id: "chkBox", header: [{ text: "선택", align: "center" }], sortable: false, resizable: false, htmlEnable: true, align: "center",
            template: function (text, row, col) { 
                // 단순 체크 이미지 (기능없음)
                return "<div class=\"form-chk ep-chk\"><input type=\"checkbox\" class=\"input--checkbox-item\" disabled=\"disabled\"><label></label></div>";
            } 
        },
        { width: 48, id: "imgurl", header: [{ text: "이미지", align: "center" }], htmlEnable: true, tooltip: true, align: "center",
            template: function (text, row, col) { 
                return "<img src=\""+text+"\" alt=\"\" class=\"thumb\">"; 
            } 
        },
        { width: 100, id: "shopname", header: [{ text: "쇼핑몰", align: "center" }], htmlEnable: true,  align: "center",
            template: function (text, row, col) { 
                return "<p class=\"tx_tit\">"+text+"</p>"; 
            } 
        },
        { width: 90, id: "price", header: [{ text: "가격", align: "center" }], htmlEnable: true, align: "right",
        template: function (text, row, col) { 
            return "<a href=\"#\" target=\"_blank\" onclick=\"alert(\'VIP 이동\');return false;\">"+text+"</a>"; 
        } 
    },
        { width: 550, id: "goodsnm", header: [{ text: "상품명", align: "center" }], htmlEnable: true, align: "left",
            template: function (text, row, col) { 
                return "<p class=\"tx_tit\">"+text+"</p>"; 
            } 
        },
        { width: 100, id: "brnd", header: [{ text: "브랜드", align: "center" }], htmlEnable: true, align: "center",
            template: function (text, row, col) { 
                return "<p class=\"tx_tit\">"+text+"</p>"; 
            } 
        },
        { width: 100, id: "score", header: [{ text: "스코어", align: "center" }], align: "center" },
        { width: 80, id: "cond02", header: [{ text: "조건1", align: "center" }], align: "center" },
        { width: 80, id: "cond04", header: [{ text: "조건2", align: "center" }], align: "center" },
        { width: 80, id: "modelno", header: [{ text: "모델번호", align: "center" }], align: "center" },
        { hidden: true, width: 80, id: "matchYn", header: [{ text: "매칭여부", align: "center" }], align: "center" },
    ],
    rowCss: function(row){
        // 매칭된 행 클래스 추가
        return row.matchYn ? "matching_row" : ""
    },
    headerRowHeight: 32,
    rowHeight: 32,
    autoWidth:true,
    //data: eslist,
    selection: "row",
    //multiselection: "ctrlClick",
    multiselection:true,
    keyNavigation: true,
    resizable:true,
    /* adjust:true, */
    tooltip: false
});
// EP상품 뷰타입(그리드/이미지) 탭바 생성
epViewContainer = new dhx.Tabbar(null, {
    css: "tab_type", 
    mode: "top",    
    tabAutoWidth: false,
    tabWidth:30,
    views: [
        { tab: "그리드뷰", id: "gridTypeList" },
        { tab: "이미지뷰", id: "imageTypeList" }
    ]
});
// EP상품 이미지뷰 위젯 생성
imageTypeList = new dhx.List("list", {
    css: "type_img", 
    template: imgViewTemplate,
    data: eslist,
    multiselection: "ctrlClick",
    keyNavigation: true
});
// EP상품 이미지뷰 목록 템플릿
function imgViewTemplate(item) {
    var template = "";
        template += "<div class='thumb_box'>";
        template += "   <div class='item_thumb'><img src='" + item.imgurl + "' alt='' /></div>";
        template += "   <div class='item_summ'>";
        template += "       <p class='tx_mall'>"+item.shopname+"</p>";
        template += "       <p class='tx_price'><em>"+item.price+"</em>원</p>";
        template += "       <p class='tx_nm' title='"+item.goodsnm+"'>"+item.goodsnm+"</p>";
        template += "       <a href='#' target='_blank' class='exlink' onclick=\"alert('VIP 이동'); return false;\">상세보기</a>";
        template += "   </div>";
        template += "   <div class=\"form-chk\">";
        template += "       <input type=\"checkbox\" id=\""+item.pl_no+"\" class=\"input--checkbox-item\"><label for=\""+item.pl_no+"\"></label>";
        template += "   </div>"
        template += "</div>";
    return template;
};


/*********************************
 * DHTMLX 위젯 생성하여, attach 합니다.
 * FORM 위젯 내 > css명 수정X
 * FORM 위젯 내 > options value 는 수정해서 사용해주세요.
 * FORM 위젯 내 > id 변경 시, 공유해 주세요.
*********************************/
// 원부 페이징 연동
grid3.data.parse(grid3_data);
var originPaging = new dhx.Pagination(null, {
    css: "",
    data: grid3.data,
    pageSize: 30 // 100단위로 바꿔주세요
});

// EP 상품 페이징 연동
// 그리드 타입일 때
grid6.data.parse(eslist)
var matchGridPaging = new dhx.Pagination(null, {
    css: "",
    data: grid6.data,
    pageSize: 30 // 100단위로 바꿔주세요
});
// 이미지 타입일때
imageTypeList.data.parse(eslist)
var matchImgPaging = new dhx.Pagination(null, {
    css: "",
    data: imageTypeList.data,
    pageSize: 30 // 100단위로 바꿔주세요
});

// 검색제외조건 찾기 FORM
var form_orgEctKwd_top = new dhx.Form(null, {
    css: "form-radio--cond",
    padding: "5px 10px",
    width: "100%",
    rows:[
        {
            id: "addOption",
            cols:[
                {
                    type: "radioGroup",
                    name: "radioGroup",
                    disabled: false,
                    required: false,
                    label: "",
                    labelWidth: 0,
                    labelPosition: "left",
                    options: {
                        cols: [
                            {
                                type: "radioButton",
                                text: "포함",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "제외",
                                value: "",
                            }
                        ]
                    },
                    css: "control-comm ipt-radio"
                },
                {
                    type: "input",
                    name: "input",
                    labelPosition: "left",
                    labelWidth: 0,
                    required: true,
                    placeholder: "",
                    css:"control-comm ipt-srch"
                },
                {
                    type: "button",
                    text: "찾기",
                    id: "btn-findcond",
                    css: "control-comm btn-find"
                }
            ]
        }
    ]    
});

// 검색제외조건 추가된 FORM, 찾기 폼(form_orgEctKwd_top)에서 추가 시, form_orgEctKwd_bottom.rows{} 추가
var form_orgEctKwd_bottom = new dhx.Form(null, {
    css: "form-radio--cond",
    padding: "5px 10px",
    width: "100%",
    rows:[
        {
            id: "optionList-1",
            cols:[
                {
                    type: "radioGroup",
                    name: "addRadio-1",
                    disabled: false,
                    required: false,
                    label: "",
                    labelWidth: 0,
                    labelPosition: "left",
                    options: {
                        cols: [
                            {
                                type: "radioButton",
                                text: "포함",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "제외",
                                value: "",
                            }
                        ]
                    },
                    css: "control-comm ipt-radio"
                },
                {
                    type: "input",
                    name: "addIpt-1",
                    labelPosition: "left",
                    labelWidth: 0,
                    required: true,
                    placeholder: "",
                    css:"control-comm ipt-srch"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btn-del-1",
                    css: "control-comm btn-find"
                }
            ]
        },
        {
            id: "optionList-2",
            cols:[
                {
                    type: "radioGroup",
                    name: "addRadio-2",
                    disabled: false,
                    required: false,
                    label: "",
                    labelWidth: 0,
                    labelPosition: "left",
                    options: {
                        cols: [
                            {
                                type: "radioButton",
                                text: "포함",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "제외",
                                value: "",
                            }
                        ]
                    },
                    css: "control-comm ipt-radio"
                },
                {
                    type: "input",
                    name: "addIpt-2",
                    labelPosition: "left",
                    labelWidth: 0,
                    required: true,
                    placeholder: "",
                    css:"control-comm ipt-srch"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btn-del-2",
                    css: "control-comm btn-find"
                }
            ]
        },
        {
            id: "optionList-3",
            cols:[
                {
                    type: "radioGroup",
                    name: "addRadio-3",
                    disabled: false,
                    required: false,
                    label: "",
                    labelWidth: 0,
                    labelPosition: "left",
                    options: {
                        cols: [
                            {
                                type: "radioButton",
                                text: "포함",
                                value: "",
                            },
                            {
                                type: "radioButton",
                                text: "제외",
                                value: "",
                            }
                        ]
                    },
                    css: "control-comm ipt-radio"
                },
                {
                    type: "input",
                    name: "addIpt-3",
                    labelPosition: "left",
                    labelWidth: 0,
                    required: true,
                    placeholder: "",
                    css:"control-comm ipt-srch"
                },
                {
                    type: "button",
                    text: "삭제",
                    id: "btn-del-3",
                    css: "control-comm btn-find"
                }
            ]
        },
    ]    
});

// EP 통합검색 FORM : 검색 영역
var matchSrchControll = new dhx.Form(null, {
    css: "controller_ep",
    padding: 0,
    width: "100%",
    cols: [
        // ************************* 220211 : SR#51192 : 셀렉트박스 추가
        {
            id: "prdcSelect",
            name: "prdcSelect",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "상품명",
            required: true,
            options: [
                {
                    value: "0",
                    content: "상품명"
                },
                {
                    value: "1",
                    content: "카탈로그번호"
                },
                {
                    value: "2",
                    content: "상품코드"
                },
                {
                    value: "3",
                    content: "PLNO"
                }
            ],
            css: "control-comm sel-sort"
        }, 
        {
            id: "keywordSelect",
            name: "select",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "전체",
            required: true,
            options: [
                {
                    value: "0",
                    content: "전체"
                },
                {
                    value: "1",
                    // ************************* 220211 : SR#51192 : 셀렉트 값 추가
                    content: "카테고리내"
                },,
                {
                    value: "2",
                    content: "키워드 포함"
                },
                {
                    value: "3",
                    content: "키워드 제외"
                }
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "keywordInput",
            name: "input",
            type: "input",
            label: "",
            labelPosition: "left",
            icon: "dxi dxi-magnify",
            labelWidth: 0,
            required: true,
            placeholder: "검색어를 입력하세요.",
            css: "control-comm ipt-srch"
        },
        {
            id: "keywordSubmit",
            type: "button",
            text:"검색",
            css: "control-comm btn-srch"
        }
    ]
})

// EP 버튼 좌측 FORM : 매칭, 매칭해제
var epGridControll = new dhx.Form(null, {
    css: "controller_sort",
    padding: 0,
    width: "100%",
    height:"42px",
    cols: [
        {
            type: "button",
            text: "전체선택",
            id: "allCheck",
            align:"left",
            size: "small",
            css: "control-comm btn-cond btn-all"
        },
        {
            type: "button",
            text: "매칭",
            id: "btnMatching1",
            align:"left",
            size: "small",
            css: "control-comm btn-cond btn-matching"
        },
        {
            type: "button",
            text: "매칭해제",
            id: "btnMatching2",
            align:"left",
            size: "small",
            css: "control-comm btn-cond"
        }
    ]
})

// EP 버튼 우측 FORM : 가매칭, 그룹매칭, 매칭
var epGridSorting = new dhx.Form(null, {
    css: "control-comm ep-chkbox",
    width:"100%",
    height:"42px",
    align: "end",
    rows: [
        {
            id: "epSorting",
            // ************************* 220211 : SR#51192 : 체크박스 영역 수정
            cols:[
                {
                    //클릭시 그리드 정렬
                    type: "button",
                    id: "btnSortExecute",
                    text: "조회",
                    css:"btn-sort_execute"
                },
                {
                    type: "checkbox",
                    disabled: false,
                    required: false,
                    hidden: false,
                    text: "가매칭"
                },
                {
                    //클릭시 팝업
                    type: "button",
                    id: "layPop1",
                    css:"btn-gmopen"
                },
                {                    
                    type: "checkbox",
                    disabled: false,
                    required: false,
                    hidden: false,
                    text: "매칭"
                },
                {
                    //클릭시 팝업
                    type: "button",
                    id: "layPop2",
                    css:"btn-gmopen"
                },
                {
                    type: "checkbox",
                    disabled: false,
                    required: false,
                    hidden: false,
                    text: "미매칭(구현예정)"
                },
                {
                    type: "checkbox",
                    disabled: false,
                    required: false,
                    hidden: false,
                    text: "품절포함",
                    css: "ep-mathing_soldout"
                },
            ]
        }
    ]
})

// ************************* 220211 : SR#51192 : 매칭/가매칭 팝업 추가
/* 가매칭 팝업 */
var popMatching1 = new dhx.Popup({
    css: "pop_groupMatching"
});
var popMatchingHtml = "";

popMatchingHtml += "<div class=\"lay_gm\">";
popMatchingHtml += "   <p class=\"tx_tit\">가매칭 항목 설정</p>";
popMatchingHtml += "   <ul>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_1\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_1\">대량정제 색인데이터</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_2\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_2\">제조사품번(그룹매칭)</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_3\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_3\">에누리모델명(그룹매칭)</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_4\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_4\">N크롤링</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_5\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_5\">D크롤링</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_6\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_6\">DCAMS-5</label></li>";
popMatchingHtml += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching1_7\" class=\"input--checkbox-item\" checked=\"checked\"><label for=\"matching1_7\">FAMS</label></li>";
popMatchingHtml += "   <ul>";
popMatchingHtml += "</div>";
popMatching1.attachHTML(popMatchingHtml);
epGridSorting.getItem("layPop1").events.on("click", function(e){
    popMatching1.show(e.srcElement);
})

/* 매칭 팝업 */
var popMatching2 = new dhx.Popup({
    css: "pop_groupMatching"
});
var popMatchingHtml2 = "";

popMatchingHtml2 += "<div class=\"lay_gm\">";
popMatchingHtml2 += "   <p class=\"tx_tit\">매칭 항목 설정</p>";
popMatchingHtml2 += "   <ul>";
popMatchingHtml2 += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching2_1\" class=\"input--checkbox-item\"><label for=\"matching2_1\">일반매칭</label></li>";
popMatchingHtml2 += "	    <li class=\"form-chk\"><input type=\"checkbox\" id=\"matching2_2\" class=\"input--checkbox-item\"><label for=\"matching2_2\">그룹(자동)매칭</label></li>";
popMatchingHtml2 += "   <ul>";
popMatchingHtml2 += "</div>";
popMatching2.attachHTML(popMatchingHtml2);
epGridSorting.getItem("layPop2").events.on("click", function(e){
    popMatching2.show(e.srcElement);
})


// EP상품 통합 검색 키워드 추가 TABBAR
var keywordAdd = new dhx.Tabbar(null, {
    css: "dhx_widget--bordered",
    mode: "top",
    tabAutoWidth: false,
    closable: true,
    noContent: true,
    /* views: [
        { tab: "-제외키워드", id:"keyword-1" },
        { tab: "-제외키워드", id:"keyword-2" },
        { tab: "+포함키워드", id:"keyword-3" },
        { tab: "-키워드", id:"keyword-4" },
        { tab: "+포함키워드", id:"keyword-5" },
        { tab: "-키워드", id:"keyword-6" },
        { tab: "-키워드", id:"keyword-7" },
        { tab: "-키워드", id:"keyword-8" },
        { tab: "-키워드", id:"keyword-9" },
        { tab: "-키워드", id:"keyword-10" },
        { tab: "-키워드", id:"keyword-11" },
    ], */
    css: "keyword_list"
});


// ************************* 220211 : SR#51192 : 상단 통합 검색 키워드 탭바 추가 
// 상단 통합 검색 키워드 추가 TABBAR
var wrapKeywordAdd = new dhx.Tabbar(null, {
    css: "dhx_widget--bordered",
    mode: "top",
    tabAutoWidth: false,
    closable: true,
    noContent: true,
    /* views: [
        { tab: "-제외키워드", id:"keyword-1" },
        { tab: "-제외키워드", id:"keyword-2" },
        { tab: "+포함키워드", id:"keyword-3" },
        { tab: "-키워드", id:"keyword-4" },
        { tab: "+포함키워드", id:"keyword-5" },
        { tab: "-키워드", id:"keyword-6" },
        { tab: "-키워드", id:"keyword-7" },
        { tab: "-키워드", id:"keyword-8" },
        { tab: "-키워드", id:"keyword-9" },
        { tab: "-키워드", id:"keyword-10" },
        { tab: "-키워드", id:"keyword-11" },
    ], */
    css: "keyword_list_all"
});


/* EP그리드 우클릭 (개발 common.js 참고) */
var popup = new dhx.Popup({
    css: "pop_headecell-sort"
});
var popHtml = "";

popHtml += "<div>";
popHtml += "	<input type=\'checkbox\' id=\'imgurl\' name=\'escustom\' onclick='customField(\"imgurl\");' checked='checked'>이미지	<br>";
popHtml += "	<input type=\'checkbox\' id=\'shopname\' name=\'escustom\' onclick='customField(\"shopname\");' checked='checked'>쇼핑몰	<br>";
popHtml += "	<input type=\'checkbox\' id=\'price\' name=\'escustom\' onclick='customField(\"price\");' checked='checked'>가격	<br>";
popHtml += "	<input type=\'checkbox\' id=\'goodsnm\' name=\'escustom\' onclick='customField(\"goodsnm\");' checked='checked'>상품명	<br>";
popHtml += "	<input type=\'checkbox\' id=\'brnd\' onclick=\'customField(\"brnd\");\' name='escustom' checked='checked'>브랜드	<br>";
popHtml += "	<input type=\'checkbox\' id=\'cond02\' onclick=\'customField(\"cond02\");\' name='escustom' checked='checked'>원부조건	<br>";
popHtml += "	<input type=\'checkbox\' id=\'cond03\' onclick=\'customField(\"cond03\");\' name='escustom' checked='checked'>조건1	<br>";
popHtml += "	<input type=\'checkbox\' id=\'cond04\' onclick=\'customField(\"cond04\");\' name='escustom' checked='checked'>조건2	<br>";
popHtml += "	<input type=\'checkbox\' id=\'score\' onclick=\'customField(\"score\");\' name='escustom' checked='checked'>스코어	<br>";
popHtml += "	<input type=\'checkbox\' id=\'modelno\' onclick=\'customField(\"modelno\");\' name='escustom' checked='checked'>모델번호	<br>";
popHtml += "	<input type=\'checkbox\' id=\'matchYn\' onclick=\'customField(\"matchYn\");\' name=\'escustom\' checked=\'checked\'>매칭여부";
popHtml += "</div>";
popup.attachHTML(popHtml);
const pconfig = {
    centering: true,
    mode: "bottom",
    indent: 0
};
grid6.events.on("headerCellRightClick", function(col, e){
    e.preventDefault();
    popup.show(e.srcElement, pconfig);
})
function customField(item) {
	if(!$("#"+item).is(":checked")){
		grid6.hideColumn(item);
	}else{
		grid6.showColumn(item);
	}
}
/* // */

// ************************* 220211 : SR#51192 : 상단 통합검색 영역 추가
// 통합검색 FORM : 검색 영역
var wrapSrchControll = new dhx.Form(null, {
    css: "controller_all",
    padding: 0,
    width: "100%",
    cols: [
        {
            id: "selectStep1",
            name: "selectStep1",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "통합",
            required: true,
            options: [
                {
                    value: "0",
                    content: "통합"
                },
                {
                    value: "1",
                    content: "카탈로그번호"
                },
                {
                    value: "2",
                    content: "원부명"
                },
                {
                    value: "3",
                    content: "제조사"
                },
                {
                    value: "4",
                    content: "브랜드"
                }
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "selectStep2",
            name: "selectStep2",
            type: "select",
            label: "",
            labelPosition: "left",
            labelWidth: 0,
            value: "전체",
            required: true,
            options: [
                {
                    value: "0",
                    content: "전체"
                },
                {
                    value: "1",
                    content: "카테고리내"
                },
                {
                    value: "2",
                    content: "키워드포함"
                },
                {
                    value: "3",
                    content: "키워드제외"
                },
            ],
            css: "control-comm sel-sort"
        },
        {
            id: "allKeywordInput",
            name: "input",
            type: "input",
            label: "",
            labelPosition: "left",
            icon: "dxi dxi-magnify",
            labelWidth: 0,
            required: true,
            placeholder: "검색어를 입력하세요.",
            css: "control-comm ipt-srch"
        },
        {
            id: "allKeywordSubmit",
            type: "button",
            text:"검색",
            css: "control-comm btn-srch"
        }
    ]
})

/*********************************
 * 전체 레이아웃 생성
*********************************/
var config = {
    type: "line", // space, wide, line
    width:"100%",
    maxWidth:"100%",
    rows: [
        {
            // 상단 툴바
            id: "toolbar",
            height: "40px",
            html: headerComponent,
            collapsable: false
        },
        {
            // 컨텐츠 레이아웃 
            type: "line",
            width:"100%",
            cols: [
                {
                    // 사이드바
                    type: "line",
                    id: "sidebar",
                    width: "240px"
                },
                {
                    // 그리드 컨텐츠 
                    rows:[
                        {
                            // ************************* 220211 : SR#51192 : 상단 통합검색 영역 추가
                            height: "56px",
                            cols:[
                                {
                                    // EP상품 ROW : 검색&키워드
                                    width:"calc(100% - 560px)",
                                    height:"56px",
                                    cols: [
                                        {
                                            // 통합검색 : 검색 영역
                                            id: "wrapSearch",
                                            width: "440px",
                                            height:"56px"
                                        },
                                        {
                                            // 통합검색 : 키워드 영역
                                            id: "wrapSearchKeyword",
                                            width: "calc(100% -  440px)",
                                            height:"56px",
                                        }
                                    ] 
                                },
                                {
                                    // 상단 툴바
                                    id: "pageUtility",
                                    width: "480px",
                                    height: "56px",
                                    html: pageUtilComponent,
                                    css:"page_utility",
                                    collapsable: false
                                },
                                {
                                    // 레이아웃 변경 버튼
                                    id: "changeLayout",
                                    width: "80px",
                                    height: "56px",
                                    html: changeViewBtn,
                                    collapsable: false
                                }
                            ]                            
                        },
                        {
                            type:"space",
                            id: "gridContent",
                            cols:[
                                {
                                    // 원부&검색제외조건 COL
                                    type: "line",
                                    id:"col-3",
                                    width:"666px",
                                    headerHeight:32,
                                    header:"원부 (48)",
                                    collapsable: true,
                                    resizable:true,
                    
                                    rows:[
                                        {
                                            // 원부 ROW 
                                            id:"col-3-top",
                                            resizable:true,
                                            cols:[
                                                {
                                                    // 원부 COL
                                                    width:"100%",
                                                    rows:[
                                                        {
                                                            // 원부 HEADER
                                                            id:"orgheader",
                                                            html:originComponent,
                                                            height:"48px"
                                                        },
                                                        {
                                                            // 원부 GRID
                                                            id:"orggrid",
                                                            height:"calc(100% - 90px)"
                                                        },
                                                        {
                                                            // 원부 PAGING
                                                            id:"originPaging",
                                                            height:"42px"
                                                        }
                                                    ]
                                                }
                                            ],
                                        },        
                                        {
                                            // 검색제외조건 영역
                                            id:"orgEctKwdgrid",
                                            headerHeight:32,
                                            header: "검색 제외 조건",
                                            collapsable: true,
                                            collapsed: true,
                                            height:"220px",
        
                                            cols:[
                                                {
                                                    // 검색제외조건 COL
                                                    width:"100%",
                                                    rows: [
                                                        {
                                                            // 검색제외조건 추가
                                                            id: "orgEctKwd-top",
                                                            // ************************* 220121 : SR#51071 : 높이 변경 48 -> 40
                                                            height:"40px"
                                                        },
                                                        {
                                                            // 검색제외조건 목록 : FORM 위젯
                                                            id: "orgEctKwd-bottom"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                },
                                {
                                    // 조건&추천조건 COL
                                    type: "line",
                                    id:"col-4",
                                    width:"222px",
                                    headerHeight:32,
                                    header:"조건 (287)",
                                    collapsable: true,
                                    resizable:true,
                                    
                                    rows:[
                                        {       
                                            // 조건 ROW
                                            id:"col-4-top",
                                            resizable:true,                     
                                            cols:[
                                                {
                                                    // 조건 COL
                                                    width:"100%",
                                                    rows:[
                                                        {
                                                            // 조건 HEADER
                                                            id:"orgcondheader",
                                                            html: termComponent,
                                                            height:"48px"
                                                        },
                                                        {
                                                            // 조건 GRID
                                                            id:"orgcondgrid",
                                                            height:"calc(100% - 48px)"
                                                        },
                                                    ]
                                                }
                                            ],
                                        },                        
                                        {
                                            // 추천 조건 ROW : GRID
                                            id:"statgrid",
                                            headerHeight:32,
                                            header: "추천 조건 (287)",
                                            collapsable: true,     
                                            height:"220px",  
                                        }
                                    ]
                                },
                                {
                                    // EP상품 COL
                                    type: "line",
                                    id: "col-5",                    
                                    resizable: true,
                                    rows:[
                                        {    
                                            // EP상품 ROW : 검색&키워드
                                            width:"100%",
                                            height:"42px",
                                            cols: [
                                                {
                                                    // EP 통합검색 : 검색 영역
                                                    id:"epSearch",
                                                    // ************************* 220211 : SR#51192 : 너비 변경   340 -> 440
                                                    width:"440px",
                                                },
                                                {
                                                    // EP 통합검색 : 키워드 영역
                                                    id:"epSearchKeyword",
                                                    // ************************* 220211 : SR#51192 : 너비 변경   340 -> 440
                                                    width:"calc(100% - 440px)",
                                                }
                                            ]      
                                        },
                                        {
                                            // EP상품 ROW : 정보
                                            id:"epProductInfo",
                                            html: matchingComponent,
                                            height:"82px"
                                        },
                                        {
                                            // EP상품 ROW : 버튼 컨트롤
                                            height:"42px",
                                            cols: [
                                                {
                                                    // 버튼 좌측 : 전체선택,매칭,매칭해제
                                                    id: "epGridControll",
                                                    width:"205px",
                                                },
                                                {
                                                    // 버튼 우측 : 매칭/미매칭 정렬
                                                    id: "epGridSorting",
                                                    width:"calc(100% - 277px)",
                                                },
                                                {
                                                    // 우측 뷰타입 버튼 넣기 위한 빈 공간 
                                                    width:"72px",
                                                    html: viewTypeChange
                                                }
                                            ]
                                        },
                                        {
                                            // EP상품 ROW : 정보
                                            id:"epPrdcList",
                                            resizable:true, 
        
                                            cols:[
                                                {
                                                    // EP상품 COL : 그리드&리스트 뷰
                                                    id:"epGridBox",
                                                    header:"",
                                                    width:"100%",
                                                    height:"100%",
        
                                                    rows:[
                                                        {
                                                            // EP 상품 그리드&리스트 목록 컨테이너
                                                            id:"epTabContainer",
                                                            height:"calc(100% - 78px)"
                                                        },
                                                        {
                                                            // 선택 상품명 표시
                                                            id:"modelNameBox",
                                                            html: modelNameBox,
                                                            height:"36px"
                                                        },
                                                        {
                                                            // 미매칭 페이징 영역
                                                            id:"matchPaging",
                                                            height:"42px"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ],
                                },
                            ]
                        }
                    ]
                    
                },
            ],
        },
    ]
};


/*********************************
 * 생성된 레이아웃에 ID별로 attach합니다.
*********************************/
var layout = new dhx.Layout("layout", config);

    layout.getCell("sidebar").attach(sidebar)

    // ************************* 220211 : SR#51192 : 상단 통합검색 ATTACH
    layout.getCell("wrapSearch").attach(wrapSrchControll); // 상단 통합검색
    layout.getCell("wrapSearchKeyword").attach(wrapKeywordAdd); // 상단 통합검색 : 키워드 영역

    // GRID 세팅
    layout.getCell("orggrid").attach(grid3); // 원부 GRID    
    layout.getCell("orgcondgrid").attach(grid4); // 조건 GRID
    layout.getCell("statgrid").attach(grid5); // 추천조건 GRID

    layout.getCell("originPaging").attach(originPaging); // 원부 PAGING
    layout.getCell("matchPaging").attach(matchGridPaging); // EP상품 페이징 (그리드)

    layout.getCell("orgEctKwd-top").attach(form_orgEctKwd_top); // 검색제외조건 추가 FORM
    layout.getCell("orgEctKwd-bottom").attach(form_orgEctKwd_bottom); // 검색제외조건 목록 FORM

    layout.getCell("epSearch").attach(matchSrchControll); // EP 통합검색 : 검색 영역
    layout.getCell("epSearchKeyword").attach(keywordAdd); // EP 통합검색 : 키워드 영역

    layout.getCell("epGridControll").attach(epGridControll); // EP 버튼 좌측 : 전체선택, 매칭, 0(제외)
    layout.getCell("epGridSorting").attach(epGridSorting); // EP 버튼 우측 : 전체선택, 미매칭보기, 매칭보기

    layout.getCell("epTabContainer").attach(epViewContainer); // EP 상품 그리드&리스트 목록 컨테이너

    // EP상품 뷰타입 attach 합니다.
    epViewContainer.getCell("gridTypeList").attach(grid6); // EP상품 뷰타입 컨테이너 > 그리드뷰 노출
    epViewContainer.getCell("imageTypeList").attach(imageTypeList); // EP상품 뷰타입 컨테이너 > 이미지뷰 노출


/********************************* 
 * 참고 : 선택한 내용에 따라 각 헤더 내용 변경입니다.
*********************************/

    // 원부 선택 -> header 변경
    grid3.selection.events.on("afterSelect", function(row, col){
        layout.getCell("col-3").config.header="원부 (48) : " + row.gco3_name;

        layout.paint();
    });
    // 조건 선택 -> header 변경
    grid4.selection.events.on("afterSelect", function(row, col){
        layout.getCell("col-4").config.header="조건 (287) : " + row.gcol1 + " , " + row.gcol2;

        layout.paint();
    });
    // 추천조건선택 -> header 변경
    grid5.selection.events.on("afterSelect", function(row, col){
        layout.getCell("statgrid").config.header="추천 조건 (287) : " + row.gcol1 + " , " + row.gcol2;

        layout.paint();
    });

/********************************* 
 * 참고 : EP상품 그리드/리스트(이미지뷰) 선택한 상품명 표시입니다.
*********************************/

    // 매칭 그리드 선택한 마지막 값 넣어주기
    grid6.selection.events.on("afterSelect", function(row, col){
        $("#modelNameIn").val(row.goodsnm);
    });
    // 매칭 리스트(이미지뷰) 선택한 마지막 값 넣어주기
    imageTypeList.selection.events.on("afterSelect", function(row){
        var col = imageTypeList.selection.getItem(); // 선택한 상품명

        $("#modelNameIn").val(col[col.length-1].goodsnm);
    });

/********************************* 
 * 참고 : EP상품 검색 키워드 추가 기능입니다.
*********************************/
    // EP상품 폼 위젯 이벤트 : 참고(https://docs.dhtmlx.com/suite/form/api/input/input_change_event/)
    // api 참고하여 적절하게 사용해주세요
    var keywordSt = 0; // 셀렉트 초기값
    matchSrchControll.getItem("select").events.on("change", function(val){
        keywordSt = val; // 셀렉트 선택한 값 
    })
    $(function(){
        $("#keywordInput").keyup(function(e){
            if(e.key === 'Enter' || e.keyCode === 13){
                keywordSubmit();
            }
        })
    })
    matchSrchControll.getItem("keywordSubmit").events.on("click", function(e) {
        keywordSubmit();
    })
    function keywordSubmit(){ // 검색 키워드 서브밋
        var srchVal = matchSrchControll.getItem("input").getValue();
        if(srchVal != ""){
            if(keywordSt == 2){
                addKeyword("+"+srchVal); // 키워드 포함
            }else if(keywordSt == 3){
                addKeyword("-"+srchVal); // 키워드 제외
            }else{ 
                addKeyword(srchVal); // 전체선택
            }
        }else{
            matchSrchControll.getItem("input").focus(); // 포커싱
        }
        matchSrchControll.getItem("input").clear(); // 검색 후 초기화
    }
    // EP상품 키워드 추가
    function addKeyword(keyword) { 
        keywordAdd.addTab({ tab: keyword }, -1); // 뒤로 추가(-1), 앞으로 추가(0)

        matchSrchControll.getItem("input").focus(); // 포커싱
    };

// ************************* 220211 : SR#51192 : 상단 통합검색 키워드 기능 추가
/********************************* 
 * 참고 : 상단 통합 검색 키워드 추가 기능입니다.
*********************************/
    // 검색 폼 위젯 이벤트 : 참고(https://docs.dhtmlx.com/suite/form/api/input/input_change_event/)
    // api 참고하여 적절하게 사용해주세요
    $(function(){
        $("#allKeywordInput").keyup(function(e){
            if(e.key === 'Enter' || e.keyCode === 13){
                wrapKeywordSubmit();
            }
        })

        // 추가된 키워드 클릭(활성/비활성 토글)
        $(".keyword_list_all, .keyword_list").on("click", ".dhx_tabbar-tab", function(e){
            if(!$(this).hasClass("is-disabled")){ // 비활성
                $(this).addClass("is-disabled");
            }else{ // 활성
                $(this).removeClass("is-disabled");
            }
        })
    })
    wrapSrchControll.getItem("allKeywordSubmit").events.on("click", function(e) {
        wrapKeywordSubmit();
    })
    function wrapKeywordSubmit(){ // 검색 키워드 서브밋
        var srchVal = wrapSrchControll.getItem("input").getValue();
        if(srchVal != ""){
            wrapAddKeyword(srchVal); 
        }else{
            wrapSrchControll.getItem("input").focus(); // 포커싱
        }
        wrapSrchControll.getItem("input").clear(); // 검색 후 초기화
    }
    // EP상품 키워드 추가
    function wrapAddKeyword(keyword) { 
        wrapKeywordAdd.addTab({ tab: keyword }, -1); // 뒤로 추가(-1), 앞으로 추가(0)

        wrapSrchControll.getItem("input").focus(); // 포커싱
    };

/*********************************
 * 페이지 로딩 후 실행됩니다.
 * - 로딩 스피너
 * - 레이어 오픈, 팝업 오픈 등
*********************************/
$(function(){
    // 로그인 로딩
    $(".btn_login").on("click", function(){
        $(".loader_box").fadeIn()
        setTimeout(function(){
            $(".loader_box").fadeOut();

            $(".login__wrap").fadeOut();
        },2000)
        return false;
    })

    // 조건 매칭 레이어 드래그
    $('.lay-wrap .lay-comm').draggable({
        cancel :'.lay-body, .lay-foot',
        containment : "parent",
        scroll : false
    });

    // EP상품 매칭 레이어 오픈
    $("#btnMatching1, #btnMatching2").on("click", function(){
        var layer = $("#newPropertyAdd");
        layer.fadeIn(200);
    });

    // EP상품 HOVER 썸네일 APPEND
    var hoverImg = $("#prdcThumb > img");

    hoverImg.on("mouseenter", function(){ 
        var imgPosTop = $(this).offset().top; // 이미지 TOP 
        var imgPosLeft = $(this).offset().left+52; // 이미지 LEFT
        var imgSrc = $(this).attr("src"); // 이미지 SRC

        $("body").append("<div class=\"lay_thumb\" style=\"top:"+imgPosTop+"px;left:"+imgPosLeft+"px\"><img src=\""+imgSrc+"\" alt=\"\" /></div>")
        setTimeout(function(){
            $(".lay_thumb").addClass("is-animated");
        }, 500)
    }).on("mouseleave", function(){
        $(".lay_thumb").removeClass("is-animated");
        setTimeout(function(){
            $("body .lay_thumb").detach();
        }, 300)
    })

    // ************************* 220211 : SR#51192 : EP상품 옵션 전체보기 레이어 추가
    // EP상품 옵션 전체보기
    var btnOptionAll = $("#btnOptionAll");
    
    btnOptionAll.on("click", function(){
        var _this = $(this);
        var posTop = _this.offset().top+20; // 레이어 위치 TOP 
        var posLeft = _this.offset().left; // 레이어 위치 LEFT

        if(!_this.hasClass("on")){
            _this.addClass("on");
            btnOptionAll.text("닫기");
    
            var optionHtml = '';
            optionHtml += "<div id=\"layEpOption\" class=\"lay_option\" style=\"top:"+posTop+"px;left:"+posLeft+"px\">";
            optionHtml += "    <span>바디클렌저</span>";
            optionHtml += "    <span>모든피부</span>";
            optionHtml += "    <span>펌프형</span>";
            optionHtml += "    <span>수분공급</span>";
            optionHtml += "    <span>주요성분:체리블라썸,코튼플라워,트로피컬패션,문라이트릴리</span>";
            optionHtml += "    <span>900ml</span>";
            optionHtml += "</div>";
            $("body").append(optionHtml);
        }else{
            _this.removeClass("on");
            btnOptionAll.text("전체보기");
            $("body #layEpOption").detach();
        }
    })
    
    // 매칭 단축키(F6)
    $(window).on("keydown",function(e){
        var key = e.key;
        if(key == "F6"){
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;

            $("#btnMatching1").trigger("click");
            return false;
        }
    })

    // EP 그리드/이미지 뷰타입 변경 
    $(".btn_type").on("click",function(){
        var _type = $(this).data("viewtype");
        
        $(this).addClass("is-on").siblings().removeClass("is-on");
        epViewContainer.setActive(_type);

        if(_type === "gridTypeList"){
            layout.getCell("matchPaging").attach(matchGridPaging); // EP상품 페이징 그리드타입
        }else if(_type === "imageTypeList"){
            layout.getCell("matchPaging").attach(matchImgPaging); // EP상품 페이징 이미지타입
        }        
    })

    // 카테고리 함수 실행
    categoryJs();
})

// 좌측 카테고리 JS
var categoryJs = function(){
    
    var accSection = $(".acc-section"); // 카테고리별 섹션
    var accCateName = accSection.find(".acc-name"); // 카테고리 분류 (대중소미)
    var accCateLi = $(".acc-content .cate_list li"); // 카테고리 명
    var accCateExpand = $(".acc-content .btn-expand"); // 전체보기 버튼
    var accCateFold = $(".acc-content .btn-fold"); // 담당카테보기 버튼
    
    // 카테고리 분류 선택 시 확장 Toggle
    accCateName.on("click", function(){        
        var state = $(this).closest(".acc-section").hasClass("is-dont");

        if(!state){
            $(this).closest(".acc-section").toggleClass("is-expand");
            $(this).siblings(".acc-content").slideToggle();
        }
    })

    // 카테고리 명 선택 시 해당 section 닫히고, 다음 section 확장
    accCateLi.on("click", function(){
        var clickSt = $(this).hasClass("is-on"); // 카테고리명 클릭 상태
        var nextContent = $(this).closest(".acc-section").next(); // 선택한 카테고리의 다음 뎁스
        var nextState = nextContent.hasClass("is-dont");  // 다음 뎁스 확장 상태
        var thisTxt = $(this).html(); // 선택한 카테명
        var thisSelArea = $(this).closest(".acc-section").find(".tx_sel"); 
        
        if(!clickSt){ // 선택 후 다음 뎁스 열림
            $(this).addClass("is-on").siblings().removeClass("is-on");
            $(this).closest(".acc-section").removeClass("is-expand").find(".acc-content").slideUp();

            thisSelArea.html(thisTxt); // 선택한 카테고리 노출
            
            if(nextState){
                nextContent.removeClass("is-dont");
            }

            nextContent.find("li").addClass("is-shown"); // 카테고리에 맞는 네임 삽입 후 show
            setTimeout(function(){
                nextContent.addClass("is-expand").find(".acc-content").slideDown().find("li").addClass("is-shown"); // 다음 뎁스 확장
            }, 500)
        }else { // 선택 해제
            $(this).removeClass("is-on"); // 선택 해제
            thisSelArea.html(""); // 선택한 카테명 삭제
            if(nextContent.hasClass("is-expand")){
                nextContent.removeClass("is-expand").find(".acc-content").slideUp(); // 확장된 다음 뎁스 접음
                nextContent.addClass("is-dont").find(".tx_sel").html(""); // 다음 뎁스 카테명 삭제
                // 리스트 삭제해주세요
            }            
        }
    })

    // 전체카테(대,중) 보기 : 펼치기
    accCateExpand.on("click", function(){
        $(this).hide().siblings(".cate_list").find("li").addClass("is-shown");
        $(this).siblings(".btn-fold").show();
    })
    // 담당카테 보기 : 접기
    accCateFold.on("click", function(){
        $(this).hide().siblings(".cate_list").find("li").removeClass("is-shown");
        $(this).siblings(".btn-expand").show();
    })

    // 최초 한번 실행, 중카테 확장 -> CM별 진행하는 카테고리만 우선 노출
    setTimeout(onceExpand, 200);
    function onceExpand(){
        accSection.eq(1).addClass("is-expand").find(".acc-content").slideDown()
    }
}