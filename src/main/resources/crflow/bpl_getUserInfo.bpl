<?xml version="1.0" encoding="UTF-8"?>

<flow xmlns="http://www.sunline.cn/bpl" label="" author="" createDate="21-11-9 下午4:07" packageName="cn.sunline.adp.crflow" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sunline.cn/bpl BPL.xsd">
  <description></description>
  <parameters>
    <parameter name="ihead" type="java.util.Map" primitiveType="FALSE" mode="IN" value="" dimension="0" desc="input header data"/>
    <parameter name="ibody" type="java.util.Map" primitiveType="FALSE" mode="IN" value="" dimension="0" desc="input body data"/>
    <parameter name="ohead" type="java.util.Map" primitiveType="FALSE" mode="OUT" value="" dimension="0" desc="output header data"/>
    <parameter name="obody" type="java.util.Map" primitiveType="FALSE" mode="OUT" value="" dimension="0" desc="output body data"/>
  </parameters>
  <variables/>
  <node id="START0" xsi:type="START" label="Start" islogger="false">
    <sourceConnections>
      <sourceConnection id="lnk101" xsi:type="TRANSACTIONCONNECTION" sourceNode="START0" targetNode="INVOKE0" label="" default="TRUE" order="2147483647">
        <description></description>
        <condition>true</condition>
      </sourceConnection>
    </sourceConnections>
    <description></description>
    <rectangle x="91" y="141" width="32" height="32"/>
    <labelRectangle x="90" y="174" width="35" height="17"/>
  </node>
  <node id="END0" xsi:type="END" label="End" islogger="false">
    <targetConnections>
      <tartetConnection type="TRANSACTIONCONNECTION">lnk102</tartetConnection>
    </targetConnections>
    <description></description>
    <rectangle x="278" y="141" width="32" height="32"/>
    <labelRectangle x="281" y="174" width="27" height="17"/>
  </node>
  <node id="INVOKE0" xsi:type="INVOKE" label="Java组件0" islogger="false">
    <sourceConnections>
      <sourceConnection id="lnk102" xsi:type="TRANSACTIONCONNECTION" sourceNode="INVOKE0" targetNode="END0" label="" default="TRUE" order="2147483647">
        <description></description>
        <condition>true</condition>
      </sourceConnection>
    </sourceConnections>
    <targetConnections>
      <tartetConnection type="TRANSACTIONCONNECTION">lnk101</tartetConnection>
    </targetConnections>
    <description>Java组件0</description>
    <rectangle x="208" y="290" width="32" height="32"/>
    <labelRectangle x="190" y="323" width="69" height="17"/>
    <pojo class="cn.sunline.edsp.busi.cr.QuickstarBizlet" method="log">
      <parameter name="param" type="java.util.Map" primitiveType="FALSE" mode="IN" value="ibody" dimension="0" desc=""/>
      <parameter name="out" type="java.util.Map" primitiveType="FALSE" mode="OUT" value="obody" dimension="0" desc=""/>
    </pojo>
  </node>
</flow>
