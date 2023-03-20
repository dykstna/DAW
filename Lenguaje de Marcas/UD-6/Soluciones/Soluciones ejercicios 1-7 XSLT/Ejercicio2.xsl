<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="//course">
    CURSO
    Número de registro: <xsl:value-of select="reg_num"/>
    Título: <xsl:value-of select="title"/>
    Profesor/a:  <xsl:value-of select="instructor"/>
    Horario: <xsl:value-of select="days"/>. De <xsl:value-of select="time/start_time"/> a <xsl:value-of select="time/end_time"/>
  </xsl:template>
</xsl:stylesheet>
