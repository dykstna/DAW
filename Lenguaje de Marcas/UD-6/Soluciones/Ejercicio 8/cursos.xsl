<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <head>
      <title>Titulo</title>
      </head>
      <body>
        <h2>CURSOS DISPONIBLES</h2>
        <table border="solid">
            <tr>
               <th>Titulo</th> 
               <th>Profesor</th>
            </tr>
            <xsl:for-each select="//course">
            <tr>
              <td><xsl:value-of select="title"/></td>
              <td><xsl:value-of select="instructor"/></td> 
            </tr>
            </xsl:for-each>
        </table> 
      </body>  
    </html>
  </xsl:template>
</xsl:stylesheet>
