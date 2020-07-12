<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:hei = "https://digi.ub.uni-heidelberg.de/schema/tei/heiEDITIONS"
    exclude-result-prefixes="xs tei hei" >
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:template match="@*|node()">
        <xsl:copy copy-namespaces="no" >
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"></xsl:template>
    
    <xsl:template match="tei:titlePart">
        <div class="tei-line" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:back"></xsl:template>
    <xsl:template match="tei:reg"></xsl:template>
    <xsl:template match="tei:abbr"></xsl:template>
    <xsl:template match="tei:am | tei:corr | tei:lb |tei:note"></xsl:template>
    
    <xsl:template match="tei:lg">
        <xsl:apply-templates select="node()" />
    </xsl:template>
    
    <xsl:template match="tei:choice">
        <xsl:apply-templates select="node()" />
    </xsl:template>
    
    <xsl:template match="tei:orig">
        <xsl:apply-templates select="node()" />
    </xsl:template>
    
  
    
    <xsl:template match="tei:cb | tei:div | tei:ex | tei:expan | tei:front | tei:hi | hei:initial | tei:pb | tei:pc | tei:sic">
        <xsl:apply-templates select="node()" />
    </xsl:template>
    
    
    
    <xsl:template match="tei:body">
                <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <div class="column" xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <div class="tei-line" xmlns="http://www.tei-c.org/ns/1.0">
            <span class="align_nr">
                <xsl:value-of select="./@n"/>
            </span>
            <xsl:apply-templates select="node()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:w">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="node()"></xsl:apply-templates>
    </xsl:template>
<!--<div  class="column">      
       
          <div class="tei-line"><span class="align_nr">1</span> Ich bruefe in mime ſinne</div>
          <div class="tei-line"><span class="align_nr">2</span> Daz lu̍terliche minne</div>
 
        
      
    </div>-->
              
</xsl:stylesheet>