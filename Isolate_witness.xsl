<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <!--    Insert manuscript-->
    <xsl:param name="manuscript">#F</xsl:param>
    
    <xsl:template match="@*|node()">
        <xsl:copy copy-namespaces="no" >
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:key name="pagebreak" match="pb[@edRef=$manuscript]" use="following::rdg[@wit=$manuscript][1]/@n" />
    <xsl:key name="columnbreak" match="cb[@edRef=$manuscript]" use="following::rdg[@wit=$manuscript][1]/@n"/>
    
    <xsl:template match="//div">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="//head/app/rdg[@wit=$manuscript]">
                <xsl:for-each select="key('pagebreak', @n)">
                    <pb><xsl:apply-templates select="@*|node()"/></pb>
                </xsl:for-each>
                <xsl:for-each select="key('columnbreak', @n)">
                    <cb><xsl:apply-templates select="@*|node()"/></cb>
                </xsl:for-each>
                <head xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></head>
            </xsl:for-each>
        <xsl:for-each select="//l/app/rdg[@wit=$manuscript]">
            <xsl:sort select="@n" data-type="text"/>
            <xsl:for-each select="key('pagebreak', @n)">
                <pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></pb>
            </xsl:for-each>
            <xsl:for-each select="key('columnbreak', @n)">
                <cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></cb>
            </xsl:for-each>
            <l xmlns="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="xml:id"><xsl:value-of select="ancestor::l[1]/@xml:id"/></xsl:attribute>
                <xsl:attribute name="n"><xsl:value-of select="./@n"/></xsl:attribute>
                <lb xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="n"></xsl:attribute>
                </lb>
                <xsl:apply-templates select="node()"/>
            </l>
        </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="head"></xsl:template>
    
    <xsl:template match="l"></xsl:template>
    
</xsl:stylesheet>