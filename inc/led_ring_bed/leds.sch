<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.7.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="yes" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="yes" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="yes" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="yes" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="yes" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="yes" active="no"/>
<layer number="21" name="tPlace" color="7" fill="9" visible="yes" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="yes" active="no"/>
<layer number="23" name="tOrigins" color="7" fill="1" visible="yes" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="yes" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="yes" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="yes" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="yes" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="yes" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="yes" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="yes" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="yes" active="no"/>
<layer number="47" name="Measures" color="5" fill="1" visible="yes" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="yes" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="yes" active="no"/>
<layer number="51" name="tDocu" color="6" fill="9" visible="yes" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="yes" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="led">
<description>&lt;b&gt;LEDs&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;&lt;br&gt;
Extended by Federico Battaglin &lt;author&gt;&amp;lt;federico.rd@fdpinternational.com&amp;gt;&lt;/author&gt; with DUOLED</description>
<packages>
<package name="W51">
<description>&lt;b&gt;Golden DRAGON® with Lens&lt;/b&gt; Enhanced Thinfilm LED&lt;p&gt;
Source: LA_LR_LY_W51M_Pb_free[1].pdf</description>
<wire x1="-0.975" y1="1.55" x2="-1.75" y2="-0.425" width="0.2032" layer="21" curve="70.879807"/>
<wire x1="-1.35" y1="-1.225" x2="0.6" y2="-1.725" width="0.2032" layer="21" curve="66.486652"/>
<wire x1="-0.125" y1="1.825" x2="1.725" y2="0.55" width="0.2032" layer="21" curve="-75.252467"/>
<wire x1="-4.55" y1="1.375" x2="-4.725" y2="1.375" width="0.2032" layer="21"/>
<wire x1="-4.725" y1="1.375" x2="-4.725" y2="1.65" width="0.2032" layer="21"/>
<wire x1="-4.725" y1="1.65" x2="-4.525" y2="2.025" width="0.2032" layer="21"/>
<wire x1="-4.525" y1="2.025" x2="-4.35" y2="2.025" width="0.2032" layer="21"/>
<wire x1="-4.55" y1="-1.4" x2="-4.725" y2="-1.4" width="0.2032" layer="21"/>
<wire x1="-4.725" y1="-1.4" x2="-4.725" y2="-1.675" width="0.2032" layer="21"/>
<wire x1="-4.725" y1="-1.675" x2="-4.525" y2="-2.05" width="0.2032" layer="21"/>
<wire x1="-4.525" y1="-2.05" x2="-4.325" y2="-2.05" width="0.2032" layer="21"/>
<wire x1="4.55" y1="-1.4" x2="4.725" y2="-1.4" width="0.2032" layer="21"/>
<wire x1="4.725" y1="-1.4" x2="4.725" y2="-1.675" width="0.2032" layer="21"/>
<wire x1="4.725" y1="-1.675" x2="4.5" y2="-2.05" width="0.2032" layer="21"/>
<wire x1="4.5" y1="-2.05" x2="4.325" y2="-2.05" width="0.2032" layer="21"/>
<wire x1="4.55" y1="1.375" x2="4.725" y2="1.375" width="0.2032" layer="21"/>
<wire x1="4.725" y1="1.375" x2="4.725" y2="1.675" width="0.2032" layer="21"/>
<wire x1="4.725" y1="1.675" x2="4.525" y2="2.025" width="0.2032" layer="21"/>
<wire x1="4.525" y1="2.025" x2="4.35" y2="2.025" width="0.2032" layer="21"/>
<wire x1="4.55" y1="1.375" x2="-4.55" y2="1.375" width="0.2032" layer="21" curve="146.266777"/>
<wire x1="-4.55" y1="-1.4" x2="4.55" y2="-1.4" width="0.2032" layer="21" curve="145.454353"/>
<circle x="0" y="0" radius="2" width="0" layer="29"/>
<circle x="0" y="0" radius="1.775" width="0" layer="31"/>
<circle x="0" y="0" radius="4.75" width="0.2032" layer="51"/>
<circle x="0" y="0" radius="0.7004" width="0.2032" layer="21"/>
<circle x="0" y="0" radius="2.825" width="0.2032" layer="21"/>
<smd name="A" x="-5.35" y="0" dx="2.3" dy="2.3" layer="1" stop="no" cream="no"/>
<smd name="C" x="5.35" y="0" dx="2.3" dy="2.3" layer="1" stop="no" cream="no"/>
<smd name="TH@2" x="0" y="3.325" dx="13" dy="3.35" layer="1" stop="no" cream="no"/>
<smd name="TH@3" x="0" y="-3.325" dx="13" dy="3.35" layer="1" stop="no" cream="no"/>
<smd name="TH@1" x="0" y="0" dx="7.4" dy="3.4" layer="1" stop="no" cream="no"/>
<text x="-2.54" y="5.08" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-6.35" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-5.575" y1="-1" x2="-4.675" y2="1" layer="51"/>
<rectangle x1="4.65" y1="-1" x2="5.575" y2="1" layer="51" rot="R180"/>
<rectangle x1="-6.725" y1="-1.35" x2="-4" y2="1.375" layer="29"/>
<rectangle x1="3.975" y1="-1.375" x2="6.7" y2="1.35" layer="29"/>
<rectangle x1="-6.45" y1="-1.1" x2="-4.25" y2="1.1" layer="31"/>
<rectangle x1="4.25" y1="-1.1" x2="6.45" y2="1.1" layer="31"/>
<rectangle x1="3.6316" y1="-1.0539" x2="3.9618" y2="0.9904" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="LED">
<wire x1="1.27" y1="0" x2="0" y2="-2.54" width="0.254" layer="94"/>
<wire x1="0" y1="-2.54" x2="-1.27" y2="0" width="0.254" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="0" y2="-2.54" width="0.254" layer="94"/>
<wire x1="0" y1="-2.54" x2="-1.27" y2="-2.54" width="0.254" layer="94"/>
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="-1.27" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="0" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="-2.032" y1="-0.762" x2="-3.429" y2="-2.159" width="0.1524" layer="94"/>
<wire x1="-1.905" y1="-1.905" x2="-3.302" y2="-3.302" width="0.1524" layer="94"/>
<text x="3.556" y="-4.572" size="1.778" layer="95" rot="R90">&gt;NAME</text>
<text x="5.715" y="-4.572" size="1.778" layer="96" rot="R90">&gt;VALUE</text>
<pin name="C" x="0" y="-5.08" visible="off" length="short" direction="pas" rot="R90"/>
<pin name="A" x="0" y="2.54" visible="off" length="short" direction="pas" rot="R270"/>
<polygon width="0.1524" layer="94">
<vertex x="-3.429" y="-2.159"/>
<vertex x="-3.048" y="-1.27"/>
<vertex x="-2.54" y="-1.778"/>
</polygon>
<polygon width="0.1524" layer="94">
<vertex x="-3.302" y="-3.302"/>
<vertex x="-2.921" y="-2.413"/>
<vertex x="-2.413" y="-2.921"/>
</polygon>
</symbol>
<symbol name="THERMAL">
<circle x="0" y="-1.524" radius="1.397" width="0.254" layer="94"/>
<text x="-2.54" y="-5.08" size="1.778" layer="95">&gt;NAME</text>
<text x="-0.889" y="-2.032" size="1.016" layer="95">TH</text>
<pin name="TH" x="0" y="2.54" visible="off" length="short" direction="pas" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="*W51M" prefix="LED">
<description>&lt;b&gt;Golden DRAGON® with Lens&lt;/b&gt; Enhanced Thinfilm LED&lt;p&gt;
Source: LA_LR_LY_W51M_Pb_free[1].pdf</description>
<gates>
<gate name="G$1" symbol="LED" x="0" y="0"/>
<gate name="G$2" symbol="THERMAL" x="10.16" y="-2.54" addlevel="request"/>
</gates>
<devices>
<device name="" package="W51">
<connects>
<connect gate="G$1" pin="A" pad="A"/>
<connect gate="G$1" pin="C" pad="C"/>
<connect gate="G$2" pin="TH" pad="TH@1 TH@2 TH@3" route="any"/>
</connects>
<technologies>
<technology name="LA"/>
<technology name="LR"/>
<technology name="LY"/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="LED1" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
<part name="LED2" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
<part name="LED3" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
<part name="LED4" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
<part name="LED5" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
<part name="LED6" library="led" deviceset="*W51M" device="" technology="LA" value="LAW51M"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="LED1" gate="G$1" x="35.56" y="60.96" rot="R90"/>
<instance part="LED2" gate="G$1" x="50.8" y="60.96" rot="R90"/>
<instance part="LED3" gate="G$1" x="66.04" y="60.96" rot="R90"/>
<instance part="LED4" gate="G$1" x="35.56" y="48.26" rot="R90"/>
<instance part="LED5" gate="G$1" x="50.8" y="48.26" rot="R90"/>
<instance part="LED6" gate="G$1" x="66.04" y="48.26" rot="R90"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="LED1" gate="G$1" pin="C"/>
<pinref part="LED2" gate="G$1" pin="A"/>
<wire x1="40.64" y1="60.96" x2="48.26" y2="60.96" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="LED4" gate="G$1" pin="C"/>
<pinref part="LED5" gate="G$1" pin="A"/>
<wire x1="40.64" y1="48.26" x2="48.26" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="LED2" gate="G$1" pin="C"/>
<pinref part="LED3" gate="G$1" pin="A"/>
<wire x1="55.88" y1="60.96" x2="63.5" y2="60.96" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="LED5" gate="G$1" pin="C"/>
<pinref part="LED6" gate="G$1" pin="A"/>
<wire x1="55.88" y1="48.26" x2="63.5" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="LED1" gate="G$1" pin="A"/>
<wire x1="33.02" y1="60.96" x2="27.94" y2="60.96" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="LED4" gate="G$1" pin="A"/>
<wire x1="33.02" y1="48.26" x2="27.94" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="LED6" gate="G$1" pin="C"/>
<wire x1="71.12" y1="48.26" x2="73.66" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="LED3" gate="G$1" pin="C"/>
<wire x1="71.12" y1="60.96" x2="73.66" y2="60.96" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
