<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : HTML -->
    <xsl:output method="html" indent="yes"/>
    
    
    <!-- 2. DÉBUT DES DÉCLARATIONS DES VARIABLES -->
    <!-- CHEMINS DES FICHIERS DE SORTIE -->
    
    <xsl:variable name="home">
        <xsl:value-of select="concat('armee_ottomane_home','.html')"/>
        <!-- variable pour le contenu du home  -->
    </xsl:variable>
    <xsl:variable name="def1">
        <xsl:value-of select="concat('armee_ottomane_def1','.html')"/>
        <!-- variable pour le contenu de la première définition  -->
    </xsl:variable>
    <xsl:variable name="def2">
        <xsl:value-of select="concat('armee_ottomane_def2','.html')"/>
        <!-- variable pour le contenu de la deuxième définition  -->
    </xsl:variable>
    <xsl:variable name="def3">
        <xsl:value-of select="concat('armee_ottomane_def3','.html')"/>
        <!-- variable pour le contenu de la troisième définition  -->
    </xsl:variable>
    <xsl:variable name="def4">
        <xsl:value-of select="concat('armee_ottomane_def4','.html')"/>
        <!-- variable pour le contenu de la troisième définition  -->
    </xsl:variable>
    <xsl:variable name="def5">
        <xsl:value-of select="concat('armee_ottomane_def5','.html')"/>
        <!-- variable pour le contenu de la troisième définition  -->
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <HEAD> -->
    <xsl:variable name="header">
        <head>
            
            <!-- Personnalisation du CSS -->
            <style>
                body {
                margin-right: 20%; 
                margin-left: 20%; 
                margin-top: 6%;
                font-family: Garamond;
                background-color: #f2ede0;
                }
                
                a {
                color: #F6BE00;
                font-weight: bold;
                }
                
                h1 {
                text-align: center;
                margin-bottom: 6%;
                }
                
                h2, h3 {
                color: #A52A2A	;
                }
                
                footer {
                text-align: center;
                margin-top: 3%;
                }
                
            </style>
            
        </head>
    </xsl:variable>
    
    
    <!-- VARIABLE AVEC LE <FOOTER> -->
    <xsl:variable name="footer">
        <footer>
            <p><i><xsl:value-of select="//editionStmt/edition"/></i></p>
        </footer>
    </xsl:variable>
    
    
    <!-- VARIABLES AVEC LES LIENS DE RETOUR -->
    <xsl:variable name="return_home">
        <center><a href="{concat('./', $home)}">Page d'accueil</a></center>
    </xsl:variable>
    
    
    <!-- VARIABLE AVEC L'EN-TÊTE DU <BODY> DES PAGES -->
    <xsl:variable name="body_header">
        <div>
            <h1><xsl:value-of select="//titleStmt/title"/></h1>
        </div>
    </xsl:variable>
    
    <!-- FIN DES DÉCLARATIONS DES VARIABLES -->
    
    
    
    <!-- TEMPLATE MATCH SUR LA RACINE AVEC LES CALL TEMPLATES DES PAGES-->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="definition1"/>
        <xsl:call-template name="definition2"/>
        <xsl:call-template name="definition3"/>
        <xsl:call-template name="definition4"/>
        <xsl:call-template name="definition5"/>
    </xsl:template>
    
    <!-- TEMPLATE DE LA PAGE HOME -->
    <xsl:template name="home">
        <xsl:result-document href="{$home}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">  
                        <h3>Description du projet</h3>
                        <p>Bienvenue dans ce petit lexique de l'armée ottomane ! </p>
                        <p><xsl:apply-templates select="//abstract"/></p>
                        <h3>Définitions</h3>
                        <ol>
                            <a href="./{$def1}"><li>AGA</li></a>
                            <a href="./{$def2}"><li>GEBEGIS</li></a>
                            <a href="./{$def3}"><li>MUSSELINS</li></a>
                            <a href="./{$def4}"><li>SPAHIS</li></a>
                            <a href="./{$def5}"><li>TOPTCHI</li></a>
                        </ol>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- TEMPLATES DE LA PAGE DÉFINITION 1 -->
    <xsl:template name="definition1">
        <xsl:result-document href="{$def1}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div>
                        <xsl:apply-templates select="./TEI/text"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text">
        <div style="text-align: justify;">

            <!-- Si le mot peut s'écrire de 2 manières différentes, on les sépare avec un ", ou" conformément au Dictionnaire de Trévoux. -->
            <xsl:choose>
                <xsl:when test="//entry[@n='1']//orth/@n = 2">
                    <h2 style="text-align: center; padding-bottom: 2%;">
                        <xsl:apply-templates select=".//entry[@n='1']//orth[@n='1']"/>, ou 
                        <xsl:apply-templates select=".//entry[@n='1']//orth[@n='2']"/>
                    </h2>
                </xsl:when>
                <xsl:otherwise>
                    <h2 style="text-align: center; padding-bottom: 2%;">
                        <xsl:apply-templates select=".//entry[@n='1']//orth"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            
            <!-- On recopie le contenu de la définition. -->
            <p>
                <b><xsl:apply-templates select=".//entry[@n='1']/gramGrp"/></b>
                <b><xsl:apply-templates select=".//entry[@n='1']/sense/usg"/></b>
                <xsl:apply-templates select=".//entry[@n='1']/sense/def"/>
            </p>
            
            <!-- Boutons de navigation -->
            <p style="float: right"><a href="./{$def2}">GEBEGIS →</a></p>
            <p style="clear: both;"></p>
            <xsl:copy-of select="$return_home"/>
        </div>
    </xsl:template>
    
    
    <!-- TEMPLATES DE LA PAGE DÉFINITION 2 -->
    <xsl:template name="definition2">
        <xsl:result-document href="{$def2}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">
                        <!-- Ajout d'un @mode pour différencier le traitement du texte -->
                        <xsl:apply-templates select="./TEI/text" mode="definition2"/>
                        <p style="float: left"><a href="./{$def1}">← AGA</a></p>
                        <p style="float: right"><a href="./{$def3}">MUSSELINS →</a></p>
                        <p style="clear: both;"></p>
                        <xsl:copy-of select="$return_home"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text" mode="definition2">
        <xsl:choose>
            <xsl:when test="//entry[@n='2']//orth/@n = 2">
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='2']//orth[@n='1']"/>, ou 
                    <xsl:apply-templates select=".//entry[@n='2']//orth[@n='2']"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='2']//orth"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
        
        <p>
            <b><xsl:apply-templates select=".//entry[@n='2']/gramGrp"/></b>
            <b><xsl:apply-templates select=".//entry[@n='2']/sense/usg"/></b>
            <xsl:apply-templates select=".//entry[@n='2']/sense/def"/>
        </p>
    </xsl:template>
    
    
    <!-- TEMPLATES DE LA PAGE DÉFINITION 3 -->
    <xsl:template name="definition3">
        <xsl:result-document href="{$def3}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">
                        <xsl:apply-templates select="./TEI/text" mode="definition3"/>
                        <p style="float: left"><a href="./{$def2}">← GEBEGIS</a></p>
                        <p style="float: right"><a href="./{$def4}">SPAHIS →</a></p>
                        <p style="clear: both;"></p>
                        <xsl:copy-of select="$return_home"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text" mode="definition3">
        <xsl:choose>
            <xsl:when test="//entry[@n='3']//orth/@n = 2">
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='3']//orth[@n='1']"/>, ou 
                    <xsl:apply-templates select=".//entry[@n='3']//orth[@n='2']"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='3']//orth"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
        
        <p>
            <b><xsl:apply-templates select=".//entry[@n='3']/gramGrp"/></b>
            <b><xsl:apply-templates select=".//entry[@n='3']/sense/usg"/></b>
            <xsl:apply-templates select=".//entry[@n='3']/sense/def"/>
        </p>
    </xsl:template>
    
    
    <!-- TEMPLATES DE LA PAGE DÉFINITION 4 -->
    <xsl:template name="definition4">
        <xsl:result-document href="{$def4}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">
                        <xsl:apply-templates select="./TEI/text" mode="definition4"/>
                        <p style="float: left"><a href="./{$def3}">← MUSSELINS</a></p>
                        <p style="float: right"><a href="./{$def5}">TOPTCHI →</a></p>
                        <p style="clear: both;"></p>
                        <xsl:copy-of select="$return_home"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text" mode="definition4">
        <xsl:choose>
            <xsl:when test="//entry[@n='4']//orth/@n = 2">
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='4']//orth[@n='1']"/>, ou 
                    <xsl:apply-templates select=".//entry[@n='4']//orth[@n='2']"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='4']//orth"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
        
        <p>
            <b><xsl:apply-templates select=".//entry[@n='4']/gramGrp"/></b>
            <b><xsl:apply-templates select=".//entry[@n='4']/sense/usg"/></b>
            <xsl:apply-templates select=".//entry[@n='4']/sense/def"/>
        </p>
    </xsl:template>
    
    
    <!-- TEMPLATES DE LA PAGE DÉFINITION 5 -->
    <xsl:template name="definition5">
        <xsl:result-document href="{$def5}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">
                        <xsl:apply-templates select="./TEI/text" mode="definition5"/>
                        <p style="float: left"><a href="./{$def4}">← SPAHIS</a></p>
                        <p style="clear: both;"></p>
                        <xsl:copy-of select="$return_home"/>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text" mode="definition5">
        <xsl:choose>
            <xsl:when test="//entry[@n='5']//orth/@n = 2">
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='5']//orth[@n='1']"/>, ou 
                    <xsl:apply-templates select=".//entry[@n='5']//orth[@n='2']"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 style="text-align: center; padding-bottom: 2%;">
                    <xsl:apply-templates select=".//entry[@n='5']//orth"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
        
        <p>
            <b><xsl:apply-templates select=".//entry[@n='5']/gramGrp"/></b>
            <b><xsl:apply-templates select=".//entry[@n='5']/sense/usg"/></b>
            <xsl:apply-templates select=".//entry[@n='5']/sense/def"/>
        </p>
    </xsl:template>
    
    
    <!-- Conformément au Dictionnaire de Trévoux, le mot défini est recopié en italique lorsqu'il se retrouve dans la définition. -->
    <xsl:template match="hi">
        <span style="font-style:italic;">
            <xsl:apply-templates/>
        </span>  
    </xsl:template>
    
    <!-- Citations étrangères en italique -->
    <xsl:template match="foreign">
        <span style="font-style:italic;">
            <xsl:apply-templates/>
        </span>  
    </xsl:template>
    
    <!-- Titres des références bibliographiques en italique -->   
    <xsl:template match="//bibl/title">
        <span style="font-style:italic;">
            <xsl:apply-templates/>
        </span>  
    </xsl:template>
    
    
</xsl:stylesheet>