VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3e"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL RamUB
        SIGNAL RamWait
        SIGNAL RamClk
        SIGNAL RamAdv
        SIGNAL RamCre
        SIGNAL RamLB
        SIGNAL FlashStSts
        SIGNAL FlashRp
        SIGNAL MemDB(15:0)
        SIGNAL MemAdr(23:1)
        SIGNAL MemOe
        SIGNAL MemWr
        SIGNAL FlashCS
        SIGNAL RamCS
        SIGNAL XLXN_190
        SIGNAL XLXN_1264
        SIGNAL XLXN_1265
        SIGNAL XLXN_1266
        SIGNAL XLXN_1262(7:0)
        SIGNAL clk
        SIGNAL EppDstb
        SIGNAL EppAstb
        SIGNAL EppWr
        SIGNAL EppWait
        SIGNAL EppDB(7:0)
        SIGNAL EppRst
        SIGNAL XLXN_1393(7:0)
        SIGNAL XLXN_1557(7:0)
        SIGNAL XLXN_1558
        SIGNAL XLXN_1559(7:0)
        SIGNAL XLXN_1560
        PORT Output RamUB
        PORT Input RamWait
        PORT Output RamClk
        PORT Output RamAdv
        PORT Output RamCre
        PORT Output RamLB
        PORT Input FlashStSts
        PORT Output FlashRp
        PORT BiDirectional MemDB(15:0)
        PORT Output MemAdr(23:1)
        PORT Output MemOe
        PORT Output MemWr
        PORT Output FlashCS
        PORT Output RamCS
        PORT Input clk
        PORT Input EppDstb
        PORT Input EppAstb
        PORT Input EppWr
        PORT Output EppWait
        PORT BiDirectional EppDB(7:0)
        PORT Input EppRst
        BEGIN BLOCKDEF NexysOnBoardMemCtrl
            TIMESTAMP 2008 2 21 7 37 14
            RECTANGLE N 64 -1120 464 -464 
            LINE N 464 -640 528 -640 
            LINE N 464 -1056 528 -1056 
            LINE N 464 -1024 528 -1024 
            LINE N 464 -992 528 -992 
            LINE N 464 -960 528 -960 
            LINE N 464 -928 528 -928 
            LINE N 464 -896 528 -896 
            LINE N 464 -864 528 -864 
            LINE N 464 -832 528 -832 
            LINE N 464 -800 528 -800 
            LINE N 528 -768 464 -768 
            LINE N 464 -736 528 -736 
            LINE N 528 -704 464 -704 
            LINE N 464 -672 528 -672 
            RECTANGLE N 464 -604 528 -580 
            LINE N 464 -592 528 -592 
            RECTANGLE N 464 -556 528 -532 
            LINE N 464 -544 528 -544 
            RECTANGLE N 0 -1020 64 -996 
            LINE N 64 -1008 0 -1008 
            LINE N 64 -816 0 -816 
            LINE N 64 -1088 0 -1088 
            RECTANGLE N 0 -572 64 -548 
            LINE N 64 -560 0 -560 
            LINE N 0 -752 64 -752 
            LINE N 4 -624 68 -624 
            LINE N 64 -688 0 -688 
            LINE N 64 -880 0 -880 
            RECTANGLE N 0 -956 64 -932 
            LINE N 0 -944 64 -944 
            LINE N 64 -496 0 -496 
        END BLOCKDEF
        BEGIN BLOCKDEF EppCtrl
            TIMESTAMP 2008 2 21 7 50 53
            LINE N 368 -416 432 -416 
            RECTANGLE N 368 -428 432 -404 
            RECTANGLE N 368 -364 432 -340 
            LINE N 432 -352 368 -352 
            LINE N 368 -288 432 -288 
            LINE N 368 -224 432 -224 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 0 32 64 32 
            LINE N 432 -160 368 -160 
            LINE N 432 -32 368 -32 
            LINE N 368 -96 432 -96 
            LINE N 368 32 432 32 
            RECTANGLE N 368 20 432 44 
            RECTANGLE N 64 -448 368 64 
            RECTANGLE N 0 -108 64 -84 
            LINE N 0 -96 64 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF CompSel
            TIMESTAMP 2008 2 21 7 39 56
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            RECTANGLE N 64 -64 368 0 
            LINE N 368 -32 432 -32 
        END BLOCKDEF
        BEGIN BLOCK instNexysOnBoardMemCtrl NexysOnBoardMemCtrl
            PIN MemCtrlEnabled
            PIN RamCS RamCS
            PIN FlashCS FlashCS
            PIN MemWR MemWr
            PIN MemOE MemOe
            PIN RamUB RamUB
            PIN RamLB RamLB
            PIN RamCre RamCre
            PIN RamAdv RamAdv
            PIN RamClk RamClk
            PIN RamWait RamWait
            PIN FlashRp FlashRp
            PIN FlashStSts FlashStSts
            PIN FlashByte
            PIN MemAdr(23:1) MemAdr(23:1)
            PIN MemDB(15:0) MemDB(15:0)
            PIN EppWrDataIn(7:0) XLXN_1393(7:0)
            PIN ctlEppRdCycleIn XLXN_190
            PIN clk clk
            PIN regEppAdrIn(7:0) XLXN_1262(7:0)
            PIN HandShakeReqOut XLXN_1266
            PIN ctlMsmDoneOut XLXN_1264
            PIN ctlMsmStartIn XLXN_1265
            PIN ctlMsmDwrIn XLXN_1558
            PIN EppRdDataOut(7:0) XLXN_1557(7:0)
            PIN ComponentSelect XLXN_1560
        END BLOCK
        BEGIN BLOCK instEppCtrl EppCtrl
            PIN clk clk
            PIN EppAstb EppAstb
            PIN EppDstb EppDstb
            PIN EppWr EppWr
            PIN EppRst EppRst
            PIN HandShakeReqIn XLXN_1266
            PIN ctlEppDoneIn XLXN_1264
            PIN busEppIn(7:0) XLXN_1557(7:0)
            PIN ctlEppRdCycleOut XLXN_190
            PIN regEppAdrOut(7:0) XLXN_1262(7:0)
            PIN EppWait EppWait
            PIN ctlEppDwrOut XLXN_1558
            PIN ctlEppStartOut XLXN_1265
            PIN busEppOut(7:0) XLXN_1393(7:0)
            PIN EppDB(7:0) EppDB(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_1 CompSel
            PIN regEppAdrIn(7:0) XLXN_1262(7:0)
            PIN CS0_7 XLXN_1560
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH RamUB
            WIRE 2352 640 2464 640
        END BRANCH
        BEGIN BRANCH RamWait
            WIRE 2352 800 2464 800
        END BRANCH
        BEGIN BRANCH RamClk
            WIRE 2352 768 2464 768
        END BRANCH
        BEGIN BRANCH RamAdv
            WIRE 2352 736 2464 736
        END BRANCH
        BEGIN BRANCH RamCre
            WIRE 2352 704 2464 704
        END BRANCH
        BEGIN BRANCH RamLB
            WIRE 2352 672 2464 672
        END BRANCH
        BEGIN BRANCH FlashStSts
            WIRE 2352 864 2464 864
        END BRANCH
        BEGIN BRANCH FlashRp
            WIRE 2352 832 2464 832
        END BRANCH
        BEGIN BRANCH MemDB(15:0)
            WIRE 2352 1024 2464 1024
        END BRANCH
        BEGIN BRANCH MemAdr(23:1)
            WIRE 2352 976 2464 976
        END BRANCH
        BEGIN BRANCH MemOe
            WIRE 2352 608 2464 608
        END BRANCH
        BEGIN BRANCH MemWr
            WIRE 2352 576 2464 576
        END BRANCH
        BEGIN BRANCH FlashCS
            WIRE 2352 544 2464 544
        END BRANCH
        BEGIN BRANCH RamCS
            WIRE 2352 512 2464 512
        END BRANCH
        BEGIN BRANCH XLXN_190
            WIRE 1472 752 1824 752
        END BRANCH
        BEGIN BRANCH XLXN_1264
            WIRE 1472 944 1824 944
        END BRANCH
        BEGIN BRANCH XLXN_1265
            WIRE 1472 880 1824 880
        END BRANCH
        BEGIN BRANCH XLXN_1266
            WIRE 1472 816 1824 816
        END BRANCH
        BEGIN INSTANCE instNexysOnBoardMemCtrl 1824 1568 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1262(7:0)
            WIRE 1472 1008 1504 1008
            WIRE 1504 1008 1824 1008
            WIRE 1504 1008 1504 1232
            WIRE 1504 1232 1552 1232
        END BRANCH
        BEGIN BRANCH clk
            WIRE 864 560 928 560
            WIRE 928 560 1040 560
            WIRE 928 480 1824 480
            WIRE 928 480 928 560
        END BRANCH
        BEGIN INSTANCE instEppCtrl 1040 976 R0
        END INSTANCE
        BEGIN BRANCH EppDstb
            WIRE 864 688 1040 688
        END BRANCH
        BEGIN BRANCH EppAstb
            WIRE 864 624 1040 624
        END BRANCH
        BEGIN BRANCH EppWr
            WIRE 864 752 1040 752
        END BRANCH
        BEGIN BRANCH EppWait
            WIRE 848 1008 1040 1008
        END BRANCH
        BEGIN BRANCH EppDB(7:0)
            WIRE 864 880 1040 880
        END BRANCH
        BEGIN BRANCH EppRst
            WIRE 864 816 1040 816
        END BRANCH
        BEGIN BRANCH XLXN_1393(7:0)
            WIRE 1472 560 1824 560
        END BRANCH
        IOMARKER 864 688 EppDstb R180 28
        IOMARKER 864 624 EppAstb R180 28
        IOMARKER 864 816 EppRst R180 28
        IOMARKER 864 752 EppWr R180 28
        IOMARKER 864 880 EppDB(7:0) R180 28
        IOMARKER 2464 976 MemAdr(23:1) R0 28
        IOMARKER 2464 608 MemOe R0 28
        IOMARKER 2464 576 MemWr R0 28
        IOMARKER 2464 544 FlashCS R0 28
        IOMARKER 2464 512 RamCS R0 28
        IOMARKER 2464 640 RamUB R0 28
        IOMARKER 2464 672 RamLB R0 28
        IOMARKER 2464 704 RamCre R0 28
        IOMARKER 2464 736 RamAdv R0 28
        IOMARKER 2464 768 RamClk R0 28
        IOMARKER 2464 832 FlashRp R0 28
        IOMARKER 848 1008 EppWait R180 28
        IOMARKER 864 560 clk R180 28
        IOMARKER 2464 800 RamWait R0 28
        IOMARKER 2464 864 FlashStSts R0 28
        IOMARKER 2464 1024 MemDB(15:0) R0 28
        BEGIN BRANCH XLXN_1557(7:0)
            WIRE 1472 624 1824 624
        END BRANCH
        BEGIN BRANCH XLXN_1558
            WIRE 1472 688 1824 688
        END BRANCH
        BEGIN INSTANCE XLXI_1 1552 1264 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1560
            WIRE 1760 1072 1824 1072
            WIRE 1760 1072 1760 1136
            WIRE 1760 1136 1984 1136
            WIRE 1984 1136 1984 1232
        END BRANCH
    END SHEET
END SCHEMATIC
