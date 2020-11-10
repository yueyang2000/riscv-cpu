/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_641(char*, char *);
extern void execute_642(char*, char *);
extern void execute_645(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1016(char*, char *);
extern void execute_1017(char*, char *);
extern void execute_1018(char*, char *);
extern void execute_1020(char*, char *);
extern void execute_1021(char*, char *);
extern void execute_1022(char*, char *);
extern void execute_1023(char*, char *);
extern void execute_1024(char*, char *);
extern void execute_1025(char*, char *);
extern void execute_1026(char*, char *);
extern void execute_1027(char*, char *);
extern void execute_1028(char*, char *);
extern void execute_138(char*, char *);
extern void execute_161(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_817(char*, char *);
extern void execute_818(char*, char *);
extern void execute_819(char*, char *);
extern void execute_820(char*, char *);
extern void execute_821(char*, char *);
extern void execute_822(char*, char *);
extern void execute_823(char*, char *);
extern void execute_824(char*, char *);
extern void execute_825(char*, char *);
extern void execute_826(char*, char *);
extern void execute_827(char*, char *);
extern void execute_828(char*, char *);
extern void execute_829(char*, char *);
extern void execute_830(char*, char *);
extern void execute_831(char*, char *);
extern void execute_832(char*, char *);
extern void execute_833(char*, char *);
extern void execute_834(char*, char *);
extern void execute_835(char*, char *);
extern void execute_836(char*, char *);
extern void execute_837(char*, char *);
extern void execute_838(char*, char *);
extern void execute_839(char*, char *);
extern void execute_840(char*, char *);
extern void execute_841(char*, char *);
extern void execute_842(char*, char *);
extern void execute_843(char*, char *);
extern void execute_844(char*, char *);
extern void execute_845(char*, char *);
extern void execute_846(char*, char *);
extern void execute_847(char*, char *);
extern void execute_848(char*, char *);
extern void execute_849(char*, char *);
extern void execute_850(char*, char *);
extern void execute_851(char*, char *);
extern void execute_852(char*, char *);
extern void execute_853(char*, char *);
extern void execute_854(char*, char *);
extern void execute_855(char*, char *);
extern void execute_856(char*, char *);
extern void execute_857(char*, char *);
extern void execute_858(char*, char *);
extern void execute_859(char*, char *);
extern void execute_860(char*, char *);
extern void execute_861(char*, char *);
extern void execute_862(char*, char *);
extern void execute_863(char*, char *);
extern void execute_864(char*, char *);
extern void execute_865(char*, char *);
extern void execute_866(char*, char *);
extern void execute_867(char*, char *);
extern void execute_868(char*, char *);
extern void execute_869(char*, char *);
extern void execute_870(char*, char *);
extern void execute_871(char*, char *);
extern void execute_735(char*, char *);
extern void execute_738(char*, char *);
extern void execute_7(char*, char *);
extern void execute_653(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_12(char*, char *);
extern void execute_13(char*, char *);
extern void execute_14(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_17(char*, char *);
extern void execute_18(char*, char *);
extern void execute_19(char*, char *);
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_23(char*, char *);
extern void execute_25(char*, char *);
extern void execute_26(char*, char *);
extern void execute_27(char*, char *);
extern void execute_28(char*, char *);
extern void execute_29(char*, char *);
extern void execute_30(char*, char *);
extern void execute_31(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_34(char*, char *);
extern void execute_35(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_39(char*, char *);
extern void execute_40(char*, char *);
extern void execute_41(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_44(char*, char *);
extern void execute_45(char*, char *);
extern void execute_46(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void execute_49(char*, char *);
extern void execute_50(char*, char *);
extern void execute_51(char*, char *);
extern void execute_52(char*, char *);
extern void execute_53(char*, char *);
extern void execute_54(char*, char *);
extern void execute_55(char*, char *);
extern void execute_56(char*, char *);
extern void execute_57(char*, char *);
extern void execute_58(char*, char *);
extern void execute_59(char*, char *);
extern void execute_60(char*, char *);
extern void execute_61(char*, char *);
extern void execute_62(char*, char *);
extern void execute_63(char*, char *);
extern void execute_64(char*, char *);
extern void execute_65(char*, char *);
extern void execute_66(char*, char *);
extern void execute_67(char*, char *);
extern void execute_68(char*, char *);
extern void execute_69(char*, char *);
extern void execute_70(char*, char *);
extern void execute_71(char*, char *);
extern void execute_72(char*, char *);
extern void execute_73(char*, char *);
extern void execute_74(char*, char *);
extern void execute_75(char*, char *);
extern void execute_76(char*, char *);
extern void execute_77(char*, char *);
extern void execute_78(char*, char *);
extern void execute_79(char*, char *);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_82(char*, char *);
extern void execute_83(char*, char *);
extern void execute_84(char*, char *);
extern void execute_85(char*, char *);
extern void execute_86(char*, char *);
extern void execute_87(char*, char *);
extern void execute_88(char*, char *);
extern void execute_89(char*, char *);
extern void execute_90(char*, char *);
extern void execute_91(char*, char *);
extern void execute_92(char*, char *);
extern void execute_93(char*, char *);
extern void execute_94(char*, char *);
extern void execute_95(char*, char *);
extern void execute_96(char*, char *);
extern void execute_97(char*, char *);
extern void execute_98(char*, char *);
extern void execute_99(char*, char *);
extern void execute_100(char*, char *);
extern void execute_101(char*, char *);
extern void execute_102(char*, char *);
extern void execute_103(char*, char *);
extern void execute_104(char*, char *);
extern void execute_105(char*, char *);
extern void execute_106(char*, char *);
extern void execute_107(char*, char *);
extern void execute_108(char*, char *);
extern void execute_109(char*, char *);
extern void execute_110(char*, char *);
extern void execute_111(char*, char *);
extern void execute_112(char*, char *);
extern void execute_113(char*, char *);
extern void execute_114(char*, char *);
extern void execute_115(char*, char *);
extern void execute_116(char*, char *);
extern void execute_117(char*, char *);
extern void execute_118(char*, char *);
extern void execute_134(char*, char *);
extern void execute_654(char*, char *);
extern void execute_655(char*, char *);
extern void execute_658(char*, char *);
extern void execute_659(char*, char *);
extern void execute_671(char*, char *);
extern void execute_672(char*, char *);
extern void execute_673(char*, char *);
extern void execute_674(char*, char *);
extern void execute_675(char*, char *);
extern void execute_676(char*, char *);
extern void execute_677(char*, char *);
extern void execute_678(char*, char *);
extern void execute_679(char*, char *);
extern void execute_680(char*, char *);
extern void execute_681(char*, char *);
extern void execute_682(char*, char *);
extern void execute_683(char*, char *);
extern void execute_684(char*, char *);
extern void execute_685(char*, char *);
extern void execute_686(char*, char *);
extern void execute_687(char*, char *);
extern void execute_688(char*, char *);
extern void execute_689(char*, char *);
extern void execute_690(char*, char *);
extern void execute_691(char*, char *);
extern void execute_692(char*, char *);
extern void execute_693(char*, char *);
extern void execute_694(char*, char *);
extern void execute_695(char*, char *);
extern void execute_696(char*, char *);
extern void execute_697(char*, char *);
extern void execute_698(char*, char *);
extern void execute_699(char*, char *);
extern void execute_700(char*, char *);
extern void execute_701(char*, char *);
extern void execute_702(char*, char *);
extern void execute_703(char*, char *);
extern void execute_704(char*, char *);
extern void execute_705(char*, char *);
extern void execute_706(char*, char *);
extern void execute_707(char*, char *);
extern void execute_708(char*, char *);
extern void execute_709(char*, char *);
extern void execute_710(char*, char *);
extern void execute_711(char*, char *);
extern void execute_712(char*, char *);
extern void execute_713(char*, char *);
extern void execute_714(char*, char *);
extern void execute_715(char*, char *);
extern void execute_716(char*, char *);
extern void execute_717(char*, char *);
extern void execute_718(char*, char *);
extern void execute_719(char*, char *);
extern void execute_720(char*, char *);
extern void execute_721(char*, char *);
extern void execute_722(char*, char *);
extern void execute_723(char*, char *);
extern void execute_724(char*, char *);
extern void execute_725(char*, char *);
extern void execute_726(char*, char *);
extern void execute_727(char*, char *);
extern void execute_730(char*, char *);
extern void execute_140(char*, char *);
extern void execute_744(char*, char *);
extern void execute_745(char*, char *);
extern void execute_142(char*, char *);
extern void execute_748(char*, char *);
extern void execute_749(char*, char *);
extern void execute_146(char*, char *);
extern void execute_760(char*, char *);
extern void execute_761(char*, char *);
extern void execute_762(char*, char *);
extern void execute_148(char*, char *);
extern void execute_763(char*, char *);
extern void execute_150(char*, char *);
extern void execute_764(char*, char *);
extern void execute_765(char*, char *);
extern void execute_766(char*, char *);
extern void execute_767(char*, char *);
extern void execute_768(char*, char *);
extern void execute_769(char*, char *);
extern void execute_770(char*, char *);
extern void execute_771(char*, char *);
extern void execute_772(char*, char *);
extern void execute_773(char*, char *);
extern void execute_774(char*, char *);
extern void execute_775(char*, char *);
extern void execute_776(char*, char *);
extern void execute_777(char*, char *);
extern void execute_778(char*, char *);
extern void execute_779(char*, char *);
extern void execute_780(char*, char *);
extern void execute_781(char*, char *);
extern void execute_782(char*, char *);
extern void execute_783(char*, char *);
extern void execute_784(char*, char *);
extern void execute_785(char*, char *);
extern void execute_786(char*, char *);
extern void execute_787(char*, char *);
extern void execute_788(char*, char *);
extern void execute_789(char*, char *);
extern void execute_790(char*, char *);
extern void execute_791(char*, char *);
extern void execute_792(char*, char *);
extern void execute_793(char*, char *);
extern void execute_794(char*, char *);
extern void execute_795(char*, char *);
extern void execute_796(char*, char *);
extern void execute_797(char*, char *);
extern void execute_798(char*, char *);
extern void execute_799(char*, char *);
extern void execute_800(char*, char *);
extern void execute_801(char*, char *);
extern void execute_802(char*, char *);
extern void execute_803(char*, char *);
extern void execute_804(char*, char *);
extern void execute_805(char*, char *);
extern void execute_806(char*, char *);
extern void execute_807(char*, char *);
extern void execute_152(char*, char *);
extern void execute_808(char*, char *);
extern void execute_809(char*, char *);
extern void execute_154(char*, char *);
extern void execute_810(char*, char *);
extern void execute_156(char*, char *);
extern void execute_811(char*, char *);
extern void execute_812(char*, char *);
extern void execute_813(char*, char *);
extern void execute_814(char*, char *);
extern void execute_158(char*, char *);
extern void execute_160(char*, char *);
extern void execute_163(char*, char *);
extern void execute_164(char*, char *);
extern void execute_165(char*, char *);
extern void execute_167(char*, char *);
extern void execute_168(char*, char *);
extern void execute_169(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_180(char*, char *);
extern void execute_182(char*, char *);
extern void execute_872(char*, char *);
extern void execute_873(char*, char *);
extern void execute_876(char*, char *);
extern void execute_877(char*, char *);
extern void execute_878(char*, char *);
extern void execute_879(char*, char *);
extern void execute_880(char*, char *);
extern void execute_881(char*, char *);
extern void execute_882(char*, char *);
extern void execute_883(char*, char *);
extern void execute_175(char*, char *);
extern void execute_176(char*, char *);
extern void execute_874(char*, char *);
extern void execute_184(char*, char *);
extern void execute_185(char*, char *);
extern void execute_186(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void execute_192(char*, char *);
extern void execute_193(char*, char *);
extern void execute_194(char*, char *);
extern void execute_195(char*, char *);
extern void execute_196(char*, char *);
extern void execute_197(char*, char *);
extern void execute_198(char*, char *);
extern void execute_199(char*, char *);
extern void execute_200(char*, char *);
extern void execute_201(char*, char *);
extern void execute_202(char*, char *);
extern void execute_203(char*, char *);
extern void execute_204(char*, char *);
extern void execute_884(char*, char *);
extern void execute_272(char*, char *);
extern void execute_273(char*, char *);
extern void execute_279(char*, char *);
extern void execute_280(char*, char *);
extern void execute_573(char*, char *);
extern void execute_574(char*, char *);
extern void execute_575(char*, char *);
extern void execute_576(char*, char *);
extern void execute_578(char*, char *);
extern void execute_580(char*, char *);
extern void execute_581(char*, char *);
extern void execute_582(char*, char *);
extern void execute_583(char*, char *);
extern void execute_584(char*, char *);
extern void execute_585(char*, char *);
extern void execute_586(char*, char *);
extern void execute_587(char*, char *);
extern void execute_588(char*, char *);
extern void execute_589(char*, char *);
extern void execute_590(char*, char *);
extern void execute_591(char*, char *);
extern void execute_592(char*, char *);
extern void execute_593(char*, char *);
extern void execute_595(char*, char *);
extern void execute_596(char*, char *);
extern void execute_597(char*, char *);
extern void execute_598(char*, char *);
extern void execute_599(char*, char *);
extern void execute_600(char*, char *);
extern void execute_601(char*, char *);
extern void execute_603(char*, char *);
extern void execute_605(char*, char *);
extern void execute_606(char*, char *);
extern void execute_607(char*, char *);
extern void execute_608(char*, char *);
extern void execute_609(char*, char *);
extern void execute_610(char*, char *);
extern void execute_611(char*, char *);
extern void execute_612(char*, char *);
extern void execute_613(char*, char *);
extern void execute_614(char*, char *);
extern void execute_615(char*, char *);
extern void execute_616(char*, char *);
extern void execute_617(char*, char *);
extern void execute_621(char*, char *);
extern void execute_625(char*, char *);
extern void execute_640(char*, char *);
extern void execute_889(char*, char *);
extern void execute_907(char*, char *);
extern void execute_908(char*, char *);
extern void execute_909(char*, char *);
extern void execute_910(char*, char *);
extern void execute_911(char*, char *);
extern void execute_912(char*, char *);
extern void execute_913(char*, char *);
extern void execute_914(char*, char *);
extern void execute_915(char*, char *);
extern void execute_916(char*, char *);
extern void execute_917(char*, char *);
extern void execute_918(char*, char *);
extern void execute_919(char*, char *);
extern void execute_920(char*, char *);
extern void execute_921(char*, char *);
extern void execute_922(char*, char *);
extern void execute_923(char*, char *);
extern void execute_924(char*, char *);
extern void execute_925(char*, char *);
extern void execute_926(char*, char *);
extern void execute_927(char*, char *);
extern void execute_928(char*, char *);
extern void execute_929(char*, char *);
extern void execute_930(char*, char *);
extern void execute_931(char*, char *);
extern void execute_932(char*, char *);
extern void execute_933(char*, char *);
extern void execute_934(char*, char *);
extern void execute_935(char*, char *);
extern void execute_936(char*, char *);
extern void execute_937(char*, char *);
extern void execute_938(char*, char *);
extern void execute_939(char*, char *);
extern void execute_940(char*, char *);
extern void execute_941(char*, char *);
extern void execute_942(char*, char *);
extern void execute_943(char*, char *);
extern void execute_944(char*, char *);
extern void execute_945(char*, char *);
extern void execute_946(char*, char *);
extern void execute_947(char*, char *);
extern void execute_948(char*, char *);
extern void execute_949(char*, char *);
extern void execute_950(char*, char *);
extern void execute_951(char*, char *);
extern void execute_952(char*, char *);
extern void execute_953(char*, char *);
extern void execute_954(char*, char *);
extern void execute_955(char*, char *);
extern void execute_956(char*, char *);
extern void execute_957(char*, char *);
extern void execute_958(char*, char *);
extern void execute_959(char*, char *);
extern void execute_960(char*, char *);
extern void execute_961(char*, char *);
extern void execute_962(char*, char *);
extern void execute_963(char*, char *);
extern void execute_964(char*, char *);
extern void execute_965(char*, char *);
extern void execute_966(char*, char *);
extern void execute_967(char*, char *);
extern void execute_968(char*, char *);
extern void execute_969(char*, char *);
extern void execute_970(char*, char *);
extern void execute_971(char*, char *);
extern void execute_972(char*, char *);
extern void execute_973(char*, char *);
extern void execute_974(char*, char *);
extern void execute_975(char*, char *);
extern void execute_976(char*, char *);
extern void execute_977(char*, char *);
extern void execute_978(char*, char *);
extern void execute_979(char*, char *);
extern void execute_980(char*, char *);
extern void execute_981(char*, char *);
extern void execute_982(char*, char *);
extern void execute_983(char*, char *);
extern void execute_984(char*, char *);
extern void execute_985(char*, char *);
extern void execute_986(char*, char *);
extern void execute_987(char*, char *);
extern void execute_988(char*, char *);
extern void execute_989(char*, char *);
extern void execute_990(char*, char *);
extern void execute_991(char*, char *);
extern void execute_992(char*, char *);
extern void execute_993(char*, char *);
extern void execute_994(char*, char *);
extern void execute_995(char*, char *);
extern void execute_996(char*, char *);
extern void execute_997(char*, char *);
extern void execute_998(char*, char *);
extern void execute_999(char*, char *);
extern void execute_1000(char*, char *);
extern void execute_1001(char*, char *);
extern void execute_1002(char*, char *);
extern void execute_1003(char*, char *);
extern void execute_1004(char*, char *);
extern void execute_1005(char*, char *);
extern void execute_1006(char*, char *);
extern void execute_1007(char*, char *);
extern void execute_1008(char*, char *);
extern void execute_1009(char*, char *);
extern void execute_1010(char*, char *);
extern void execute_1011(char*, char *);
extern void execute_1012(char*, char *);
extern void execute_1013(char*, char *);
extern void execute_282(char*, char *);
extern void execute_284(char*, char *);
extern void execute_308(char*, char *);
extern void execute_310(char*, char *);
extern void execute_318(char*, char *);
extern void execute_319(char*, char *);
extern void execute_320(char*, char *);
extern void execute_321(char*, char *);
extern void execute_322(char*, char *);
extern void execute_323(char*, char *);
extern void execute_890(char*, char *);
extern void execute_891(char*, char *);
extern void execute_329(char*, char *);
extern void execute_331(char*, char *);
extern void execute_332(char*, char *);
extern void execute_333(char*, char *);
extern void execute_335(char*, char *);
extern void execute_337(char*, char *);
extern void execute_343(char*, char *);
extern void execute_349(char*, char *);
extern void execute_352(char*, char *);
extern void execute_353(char*, char *);
extern void execute_354(char*, char *);
extern void execute_355(char*, char *);
extern void execute_356(char*, char *);
extern void execute_892(char*, char *);
extern void execute_359(char*, char *);
extern void execute_368(char*, char *);
extern void execute_369(char*, char *);
extern void execute_380(char*, char *);
extern void execute_386(char*, char *);
extern void execute_395(char*, char *);
extern void execute_401(char*, char *);
extern void execute_413(char*, char *);
extern void execute_419(char*, char *);
extern void execute_431(char*, char *);
extern void execute_437(char*, char *);
extern void execute_438(char*, char *);
extern void execute_444(char*, char *);
extern void execute_450(char*, char *);
extern void execute_451(char*, char *);
extern void execute_460(char*, char *);
extern void execute_473(char*, char *);
extern void execute_478(char*, char *);
extern void execute_483(char*, char *);
extern void execute_484(char*, char *);
extern void execute_487(char*, char *);
extern void execute_488(char*, char *);
extern void execute_491(char*, char *);
extern void execute_492(char*, char *);
extern void execute_493(char*, char *);
extern void execute_894(char*, char *);
extern void execute_895(char*, char *);
extern void execute_896(char*, char *);
extern void execute_897(char*, char *);
extern void execute_898(char*, char *);
extern void execute_899(char*, char *);
extern void execute_900(char*, char *);
extern void execute_901(char*, char *);
extern void execute_902(char*, char *);
extern void execute_903(char*, char *);
extern void execute_904(char*, char *);
extern void execute_497(char*, char *);
extern void execute_498(char*, char *);
extern void execute_499(char*, char *);
extern void execute_500(char*, char *);
extern void execute_508(char*, char *);
extern void execute_509(char*, char *);
extern void execute_510(char*, char *);
extern void execute_511(char*, char *);
extern void execute_905(char*, char *);
extern void execute_906(char*, char *);
extern void execute_513(char*, char *);
extern void execute_523(char*, char *);
extern void execute_526(char*, char *);
extern void execute_527(char*, char *);
extern void execute_529(char*, char *);
extern void execute_531(char*, char *);
extern void execute_533(char*, char *);
extern void execute_535(char*, char *);
extern void execute_537(char*, char *);
extern void execute_539(char*, char *);
extern void execute_541(char*, char *);
extern void execute_543(char*, char *);
extern void execute_545(char*, char *);
extern void execute_547(char*, char *);
extern void execute_549(char*, char *);
extern void execute_551(char*, char *);
extern void execute_553(char*, char *);
extern void execute_555(char*, char *);
extern void execute_557(char*, char *);
extern void execute_649(char*, char *);
extern void execute_650(char*, char *);
extern void execute_651(char*, char *);
extern void execute_1029(char*, char *);
extern void execute_1030(char*, char *);
extern void execute_1031(char*, char *);
extern void execute_1032(char*, char *);
extern void execute_1033(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_23(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_138(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_140(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_141(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_147(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_148(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_149(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_150(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_151(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_153(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_154(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_155(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_156(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_157(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_158(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_159(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_160(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_161(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_162(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_163(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_164(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_165(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_169(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_173(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_176(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_981(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1268(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1273(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1276(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1303(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1305(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1307(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1308(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1309(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1310(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1312(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1618(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_329(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_330(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_406(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_407(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_408(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_409(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_439(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1405(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1406(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1407(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1408(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1409(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1410(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1411(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1412(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1488(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1489(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1490(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1512(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1513(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1514(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1515(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1533(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1536(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1537(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1559(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1560(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1561(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1584(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1585(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1586(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1620(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1621(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1622(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1623(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1698(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1832(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1833(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1834(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1835(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1836(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1837(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1838(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[701] = {(funcp)execute_2, (funcp)execute_641, (funcp)execute_642, (funcp)execute_645, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1016, (funcp)execute_1017, (funcp)execute_1018, (funcp)execute_1020, (funcp)execute_1021, (funcp)execute_1022, (funcp)execute_1023, (funcp)execute_1024, (funcp)execute_1025, (funcp)execute_1026, (funcp)execute_1027, (funcp)execute_1028, (funcp)execute_138, (funcp)execute_161, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_817, (funcp)execute_818, (funcp)execute_819, (funcp)execute_820, (funcp)execute_821, (funcp)execute_822, (funcp)execute_823, (funcp)execute_824, (funcp)execute_825, (funcp)execute_826, (funcp)execute_827, (funcp)execute_828, (funcp)execute_829, (funcp)execute_830, (funcp)execute_831, (funcp)execute_832, (funcp)execute_833, (funcp)execute_834, (funcp)execute_835, (funcp)execute_836, (funcp)execute_837, (funcp)execute_838, (funcp)execute_839, (funcp)execute_840, (funcp)execute_841, (funcp)execute_842, (funcp)execute_843, (funcp)execute_844, (funcp)execute_845, (funcp)execute_846, (funcp)execute_847, (funcp)execute_848, (funcp)execute_849, (funcp)execute_850, (funcp)execute_851, (funcp)execute_852, (funcp)execute_853, (funcp)execute_854, (funcp)execute_855, (funcp)execute_856, (funcp)execute_857, (funcp)execute_858, (funcp)execute_859, (funcp)execute_860, (funcp)execute_861, (funcp)execute_862, (funcp)execute_863, (funcp)execute_864, (funcp)execute_865, (funcp)execute_866, (funcp)execute_867, (funcp)execute_868, (funcp)execute_869, (funcp)execute_870, (funcp)execute_871, (funcp)execute_735, (funcp)execute_738, (funcp)execute_7, (funcp)execute_653, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_12, (funcp)execute_13, (funcp)execute_14, (funcp)execute_15, (funcp)execute_16, (funcp)execute_17, (funcp)execute_18, (funcp)execute_19, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_25, (funcp)execute_26, (funcp)execute_27, (funcp)execute_28, (funcp)execute_29, (funcp)execute_30, (funcp)execute_31, (funcp)execute_32, (funcp)execute_33, (funcp)execute_34, (funcp)execute_35, (funcp)execute_36, (funcp)execute_37, (funcp)execute_38, (funcp)execute_39, (funcp)execute_40, (funcp)execute_41, (funcp)execute_42, (funcp)execute_43, (funcp)execute_44, (funcp)execute_45, (funcp)execute_46, (funcp)execute_47, (funcp)execute_48, (funcp)execute_49, (funcp)execute_50, (funcp)execute_51, (funcp)execute_52, (funcp)execute_53, (funcp)execute_54, (funcp)execute_55, (funcp)execute_56, (funcp)execute_57, (funcp)execute_58, (funcp)execute_59, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_64, (funcp)execute_65, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)execute_69, (funcp)execute_70, (funcp)execute_71, (funcp)execute_72, (funcp)execute_73, (funcp)execute_74, (funcp)execute_75, (funcp)execute_76, (funcp)execute_77, (funcp)execute_78, (funcp)execute_79, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_83, (funcp)execute_84, (funcp)execute_85, (funcp)execute_86, (funcp)execute_87, (funcp)execute_88, (funcp)execute_89, (funcp)execute_90, (funcp)execute_91, (funcp)execute_92, (funcp)execute_93, (funcp)execute_94, (funcp)execute_95, (funcp)execute_96, (funcp)execute_97, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)execute_107, (funcp)execute_108, (funcp)execute_109, (funcp)execute_110, (funcp)execute_111, (funcp)execute_112, (funcp)execute_113, (funcp)execute_114, (funcp)execute_115, (funcp)execute_116, (funcp)execute_117, (funcp)execute_118, (funcp)execute_134, (funcp)execute_654, (funcp)execute_655, (funcp)execute_658, (funcp)execute_659, (funcp)execute_671, (funcp)execute_672, (funcp)execute_673, (funcp)execute_674, (funcp)execute_675, (funcp)execute_676, (funcp)execute_677, (funcp)execute_678, (funcp)execute_679, (funcp)execute_680, (funcp)execute_681, (funcp)execute_682, (funcp)execute_683, (funcp)execute_684, (funcp)execute_685, (funcp)execute_686, (funcp)execute_687, (funcp)execute_688, (funcp)execute_689, (funcp)execute_690, (funcp)execute_691, (funcp)execute_692, (funcp)execute_693, (funcp)execute_694, (funcp)execute_695, (funcp)execute_696, (funcp)execute_697, (funcp)execute_698, (funcp)execute_699, (funcp)execute_700, (funcp)execute_701, (funcp)execute_702, (funcp)execute_703, (funcp)execute_704, (funcp)execute_705, (funcp)execute_706, (funcp)execute_707, (funcp)execute_708, (funcp)execute_709, (funcp)execute_710, (funcp)execute_711, (funcp)execute_712, (funcp)execute_713, (funcp)execute_714, (funcp)execute_715, (funcp)execute_716, (funcp)execute_717, (funcp)execute_718, (funcp)execute_719, (funcp)execute_720, (funcp)execute_721, (funcp)execute_722, (funcp)execute_723, (funcp)execute_724, (funcp)execute_725, (funcp)execute_726, (funcp)execute_727, (funcp)execute_730, (funcp)execute_140, (funcp)execute_744, (funcp)execute_745, (funcp)execute_142, (funcp)execute_748, (funcp)execute_749, (funcp)execute_146, (funcp)execute_760, (funcp)execute_761, (funcp)execute_762, (funcp)execute_148, (funcp)execute_763, (funcp)execute_150, (funcp)execute_764, (funcp)execute_765, (funcp)execute_766, (funcp)execute_767, (funcp)execute_768, (funcp)execute_769, (funcp)execute_770, (funcp)execute_771, (funcp)execute_772, (funcp)execute_773, (funcp)execute_774, (funcp)execute_775, (funcp)execute_776, (funcp)execute_777, (funcp)execute_778, (funcp)execute_779, (funcp)execute_780, (funcp)execute_781, (funcp)execute_782, (funcp)execute_783, (funcp)execute_784, (funcp)execute_785, (funcp)execute_786, (funcp)execute_787, (funcp)execute_788, (funcp)execute_789, (funcp)execute_790, (funcp)execute_791, (funcp)execute_792, (funcp)execute_793, (funcp)execute_794, (funcp)execute_795, (funcp)execute_796, (funcp)execute_797, (funcp)execute_798, (funcp)execute_799, (funcp)execute_800, (funcp)execute_801, (funcp)execute_802, (funcp)execute_803, (funcp)execute_804, (funcp)execute_805, (funcp)execute_806, (funcp)execute_807, (funcp)execute_152, (funcp)execute_808, (funcp)execute_809, (funcp)execute_154, (funcp)execute_810, (funcp)execute_156, (funcp)execute_811, (funcp)execute_812, (funcp)execute_813, (funcp)execute_814, (funcp)execute_158, (funcp)execute_160, (funcp)execute_163, (funcp)execute_164, (funcp)execute_165, (funcp)execute_167, (funcp)execute_168, (funcp)execute_169, (funcp)execute_171, (funcp)execute_172, (funcp)execute_180, (funcp)execute_182, (funcp)execute_872, (funcp)execute_873, (funcp)execute_876, (funcp)execute_877, (funcp)execute_878, (funcp)execute_879, (funcp)execute_880, (funcp)execute_881, (funcp)execute_882, (funcp)execute_883, (funcp)execute_175, (funcp)execute_176, (funcp)execute_874, (funcp)execute_184, (funcp)execute_185, (funcp)execute_186, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_190, (funcp)execute_191, (funcp)execute_192, (funcp)execute_193, (funcp)execute_194, (funcp)execute_195, (funcp)execute_196, (funcp)execute_197, (funcp)execute_198, (funcp)execute_199, (funcp)execute_200, (funcp)execute_201, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_884, (funcp)execute_272, (funcp)execute_273, (funcp)execute_279, (funcp)execute_280, (funcp)execute_573, (funcp)execute_574, (funcp)execute_575, (funcp)execute_576, (funcp)execute_578, (funcp)execute_580, (funcp)execute_581, (funcp)execute_582, (funcp)execute_583, (funcp)execute_584, (funcp)execute_585, (funcp)execute_586, (funcp)execute_587, (funcp)execute_588, (funcp)execute_589, (funcp)execute_590, (funcp)execute_591, (funcp)execute_592, (funcp)execute_593, (funcp)execute_595, (funcp)execute_596, (funcp)execute_597, (funcp)execute_598, (funcp)execute_599, (funcp)execute_600, (funcp)execute_601, (funcp)execute_603, (funcp)execute_605, (funcp)execute_606, (funcp)execute_607, (funcp)execute_608, (funcp)execute_609, (funcp)execute_610, (funcp)execute_611, (funcp)execute_612, (funcp)execute_613, (funcp)execute_614, (funcp)execute_615, (funcp)execute_616, (funcp)execute_617, (funcp)execute_621, (funcp)execute_625, (funcp)execute_640, (funcp)execute_889, (funcp)execute_907, (funcp)execute_908, (funcp)execute_909, (funcp)execute_910, (funcp)execute_911, (funcp)execute_912, (funcp)execute_913, (funcp)execute_914, (funcp)execute_915, (funcp)execute_916, (funcp)execute_917, (funcp)execute_918, (funcp)execute_919, (funcp)execute_920, (funcp)execute_921, (funcp)execute_922, (funcp)execute_923, (funcp)execute_924, (funcp)execute_925, (funcp)execute_926, (funcp)execute_927, (funcp)execute_928, (funcp)execute_929, (funcp)execute_930, (funcp)execute_931, (funcp)execute_932, (funcp)execute_933, (funcp)execute_934, (funcp)execute_935, (funcp)execute_936, (funcp)execute_937, (funcp)execute_938, (funcp)execute_939, (funcp)execute_940, (funcp)execute_941, (funcp)execute_942, (funcp)execute_943, (funcp)execute_944, (funcp)execute_945, (funcp)execute_946, (funcp)execute_947, (funcp)execute_948, (funcp)execute_949, (funcp)execute_950, (funcp)execute_951, (funcp)execute_952, (funcp)execute_953, (funcp)execute_954, (funcp)execute_955, (funcp)execute_956, (funcp)execute_957, (funcp)execute_958, (funcp)execute_959, (funcp)execute_960, (funcp)execute_961, (funcp)execute_962, (funcp)execute_963, (funcp)execute_964, (funcp)execute_965, (funcp)execute_966, (funcp)execute_967, (funcp)execute_968, (funcp)execute_969, (funcp)execute_970, (funcp)execute_971, (funcp)execute_972, (funcp)execute_973, (funcp)execute_974, (funcp)execute_975, (funcp)execute_976, (funcp)execute_977, (funcp)execute_978, (funcp)execute_979, (funcp)execute_980, (funcp)execute_981, (funcp)execute_982, (funcp)execute_983, (funcp)execute_984, (funcp)execute_985, (funcp)execute_986, (funcp)execute_987, (funcp)execute_988, (funcp)execute_989, (funcp)execute_990, (funcp)execute_991, (funcp)execute_992, (funcp)execute_993, (funcp)execute_994, (funcp)execute_995, (funcp)execute_996, (funcp)execute_997, (funcp)execute_998, (funcp)execute_999, (funcp)execute_1000, (funcp)execute_1001, (funcp)execute_1002, (funcp)execute_1003, (funcp)execute_1004, (funcp)execute_1005, (funcp)execute_1006, (funcp)execute_1007, (funcp)execute_1008, (funcp)execute_1009, (funcp)execute_1010, (funcp)execute_1011, (funcp)execute_1012, (funcp)execute_1013, (funcp)execute_282, (funcp)execute_284, (funcp)execute_308, (funcp)execute_310, (funcp)execute_318, (funcp)execute_319, (funcp)execute_320, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_890, (funcp)execute_891, (funcp)execute_329, (funcp)execute_331, (funcp)execute_332, (funcp)execute_333, (funcp)execute_335, (funcp)execute_337, (funcp)execute_343, (funcp)execute_349, (funcp)execute_352, (funcp)execute_353, (funcp)execute_354, (funcp)execute_355, (funcp)execute_356, (funcp)execute_892, (funcp)execute_359, (funcp)execute_368, (funcp)execute_369, (funcp)execute_380, (funcp)execute_386, (funcp)execute_395, (funcp)execute_401, (funcp)execute_413, (funcp)execute_419, (funcp)execute_431, (funcp)execute_437, (funcp)execute_438, (funcp)execute_444, (funcp)execute_450, (funcp)execute_451, (funcp)execute_460, (funcp)execute_473, (funcp)execute_478, (funcp)execute_483, (funcp)execute_484, (funcp)execute_487, (funcp)execute_488, (funcp)execute_491, (funcp)execute_492, (funcp)execute_493, (funcp)execute_894, (funcp)execute_895, (funcp)execute_896, (funcp)execute_897, (funcp)execute_898, (funcp)execute_899, (funcp)execute_900, (funcp)execute_901, (funcp)execute_902, (funcp)execute_903, (funcp)execute_904, (funcp)execute_497, (funcp)execute_498, (funcp)execute_499, (funcp)execute_500, (funcp)execute_508, (funcp)execute_509, (funcp)execute_510, (funcp)execute_511, (funcp)execute_905, (funcp)execute_906, (funcp)execute_513, (funcp)execute_523, (funcp)execute_526, (funcp)execute_527, (funcp)execute_529, (funcp)execute_531, (funcp)execute_533, (funcp)execute_535, (funcp)execute_537, (funcp)execute_539, (funcp)execute_541, (funcp)execute_543, (funcp)execute_545, (funcp)execute_547, (funcp)execute_549, (funcp)execute_551, (funcp)execute_553, (funcp)execute_555, (funcp)execute_557, (funcp)execute_649, (funcp)execute_650, (funcp)execute_651, (funcp)execute_1029, (funcp)execute_1030, (funcp)execute_1031, (funcp)execute_1032, (funcp)execute_1033, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_23, (funcp)transaction_41, (funcp)transaction_138, (funcp)transaction_140, (funcp)transaction_141, (funcp)transaction_147, (funcp)transaction_148, (funcp)transaction_149, (funcp)transaction_150, (funcp)transaction_151, (funcp)transaction_153, (funcp)transaction_154, (funcp)transaction_155, (funcp)transaction_156, (funcp)transaction_157, (funcp)transaction_158, (funcp)transaction_159, (funcp)transaction_160, (funcp)transaction_161, (funcp)transaction_162, (funcp)transaction_163, (funcp)transaction_164, (funcp)transaction_165, (funcp)transaction_169, (funcp)transaction_173, (funcp)transaction_176, (funcp)transaction_981, (funcp)transaction_1268, (funcp)transaction_1273, (funcp)transaction_1276, (funcp)transaction_1303, (funcp)transaction_1305, (funcp)transaction_1307, (funcp)transaction_1308, (funcp)transaction_1309, (funcp)transaction_1310, (funcp)transaction_1312, (funcp)transaction_1618, (funcp)transaction_329, (funcp)transaction_330, (funcp)transaction_406, (funcp)transaction_407, (funcp)transaction_408, (funcp)transaction_409, (funcp)transaction_439, (funcp)transaction_1405, (funcp)transaction_1406, (funcp)transaction_1407, (funcp)transaction_1408, (funcp)transaction_1409, (funcp)transaction_1410, (funcp)transaction_1411, (funcp)transaction_1412, (funcp)transaction_1488, (funcp)transaction_1489, (funcp)transaction_1490, (funcp)transaction_1512, (funcp)transaction_1513, (funcp)transaction_1514, (funcp)transaction_1515, (funcp)transaction_1533, (funcp)transaction_1536, (funcp)transaction_1537, (funcp)transaction_1559, (funcp)transaction_1560, (funcp)transaction_1561, (funcp)transaction_1584, (funcp)transaction_1585, (funcp)transaction_1586, (funcp)transaction_1620, (funcp)transaction_1621, (funcp)transaction_1622, (funcp)transaction_1623, (funcp)transaction_1698, (funcp)transaction_1832, (funcp)transaction_1833, (funcp)transaction_1834, (funcp)transaction_1835, (funcp)transaction_1836, (funcp)transaction_1837, (funcp)transaction_1838};
const int NumRelocateId= 701;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_behav/xsim.reloc",  (void **)funcTab, 701);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
iki_register_root_pointers(31, 50702040, -7,0,50704104, -7,0,50703416, -7,0,50704792, -7,0,50706168, -7,0,50702728, -7,0,50705480, -7,0,50676864, -7,0,50645768, -7,0,50646456, -7,0,50651176, -7,0,50655584, -7,0,50656272, -7,0,50650488, -7,0,50662472, -7,0,50663848, -7,0,50663160, -7,0,50633360, -7,0,50634048, -7,0,50638280, -7,0,50638968, -7,0,50639656, -7,0,50640344, -7,0,33824952, -7,0,33823576, -7,0,33822888, -7,0,33826328, -7,0,33825640, -7,0,33824264, -7,0,33827016, -7,0,33822200, -7,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
