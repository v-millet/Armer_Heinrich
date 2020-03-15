<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="rdg/@n">
        <xsl:choose><xsl:when test="number(.)">
            <xsl:variable name="num"><xsl:value-of select="number(.)"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="($num &lt; 10000) and ($num &gt; 999)"><xsl:attribute name="n"><xsl:value-of select="$num"/></xsl:attribute></xsl:when>
            <xsl:when test="($num &lt; 1000) and ($num &gt; 99)"><xsl:attribute name="n">0<xsl:value-of select="$num"/></xsl:attribute></xsl:when>
            <xsl:when test="($num &lt; 100) and ($num &gt; 9)"><xsl:attribute name="n">00<xsl:value-of select="$num"/></xsl:attribute></xsl:when>
            <xsl:when test="($num &lt; 10)"><xsl:attribute name="n">000<xsl:value-of select="$num"/></xsl:attribute></xsl:when>
            <xsl:otherwise><xsl:attribute name="n"><xsl:value-of select="$num"/></xsl:attribute></xsl:otherwise>
        </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:attribute name="n"><xsl:value-of select="."/></xsl:attribute></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>