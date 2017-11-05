pkg load control;
pkg load signal;

######                                                   
###   VENTANA PRINCIPAL   #####                      
#####
function abrirVentanaPrincipal ()
  ventanaPrincipal = figure;
  set (ventanaPrincipal,"name","AMIC - Aproximacion por Mínimos Cuadrados");
  set (ventanaPrincipal,"numbertitle","off");
  set (ventanaPrincipal,"color",[.5,.5,.5]);
  set (ventanaPrincipal,"menubar","none"); #barra de menu principal y herramientas desaparecen

  entornoPrincipal = uibuttongroup (ventanaPrincipal, "position", [ 0 0 1 1], ...
                 "title","Elija una opción", ...
                 "titleposition","centertop","fontsize",11,"fontname","Arial");
             
  botonCoeficientes = uicontrol (entornoPrincipal,"string","Aproximar", ...
                 "position",[125,280,300,100],"callback",{@abrirVentanaAproximar}, ...
                 "backgroundcolor",[.8,.8,.8]);
  botonFinalizar = uicontrol (entornoPrincipal,"string","Finalizar", ...
                 "position",[125,150,300,100],"callback",{@cerrarVentana}, ...
                 "backgroundcolor",[.8,.8,.8]);
endfunction


###################################################################################
#                                      APROXIMAR                                  #
###################################################################################


######                                                   
###   VENTANA APROXIMAR   #####                      
#####
function abrirVentanaAproximar (handlesource,event)
  ventanaAproximar = figure;
  set (ventanaAproximar,"name","Aproximacion por minimos cuadrados");
  set (ventanaAproximar,"numbertitle","off");
  
  entornoAproximar = uibuttongroup (ventanaAproximar, "position", [ 0 0 1 1], ...
               "title","Establezca los puntos y elija su aproximacion","titleposition","centertop");
               
  textoEjeX = uicontrol (entornoAproximar,"style","text", ...
               "string","eje x:","position",[100,350,300,40], ... 
               "fontsize",16);
  ejeX = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "2,7,4", "position",[120,310,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  textoEjeY = uicontrol (entornoAproximar,"style","text", ...
               "string","Eje y :","position",[100,250,300,40], ... 
               "fontsize",16);  
  ejeY = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "6,1,9,3", "position",[120,210,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  textoCantDecimales = uicontrol (entornoAproximar,"style","text", ...
               "string","Cantidad decimales:","position",[100,150,300,40], ... 
               "fontsize",16);  
  cantDecimales = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "6,1,9,3", "position",[120,110,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
               
  botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
               "position",[150,50,200,40],"callback",...
                {@seleccionMetodos,ejeX,ejeY,cantDecimales}, ...             
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


######                                                   
###   SELECCION METODOS   #####                      
#####  
function seleccionMetodos (ejeX,ejeY,cantDecimales)
  ventanaSeleccionMetodos = figure;
  set (ventanaSeleccionMetodos,"name","Aproximacion por minimos cuadrados");
  set (ventanaSeleccionMetodos,"numbertitle","off");
  
  entornoSeleccionMetodos = uibuttongroup (ventanaSeleccionMetodos, "position", [ 0 0 1 1], ...
               "title","Elija el método de aproximación","titleposition","centertop");
               
               
  botonRecta = uicontrol (entornoSeleccionMetodos,"string"," Recta de mínimos cuadrados", ...
               "position",[150,350,250,30],"callback",...
                {@opcionesAproximacion,ejeX,ejeY,cantDecimales,1}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parábola de mínimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,2}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,4}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximación Hipérbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,5}, ...
               "backgroundcolor",[.8,.8,.8]);
  botonPCG = uicontrol (entornoPrincipal,"string","Comparar Aproximaciones", ...
                 "position",[150,100,250,30],"callback",{@abrirVentanaComAprox}, ...
                 "backgroundcolor",[.8,.8,.8]);
endfunction


######                                                   
###   OPCIONES APROXIMACION   #####                      
##### 
function opcionesAproximacion (ejeX,ejeY,cantDecimales,metodo)
  ventanaOpcionesAproximacion = figure;
  set (ventanaOpcionesAproximacion,"name","Aproximacion por minimos cuadrados");
  set (ventanaOpcionesAproximacion,"numbertitle","off");
  
  entornoOpcionesAproximacion = uibuttongroup (ventanaOpcionesAproximacion, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");
               

  botonFuncion = uicontrol (entornoOpcionesAproximacion,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproximante,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproximacion,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproximacion,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,3}, ...
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


###################################################################################
#                            FUNCION APROXIMANTE                                  #
###################################################################################

function funcionAproximante (ejeX,ejeY,cantDecimales,metodo)
  ventanaFuncionAproximante = figure;
  set (ventanaFuncionAproximante,"name","Aproximacion por minimos cuadrados");
  set (ventanaFuncionAproximante,"numbertitle","off");
  
  if (metodo == 1) #Recta
    funcionAproximanteVal = funcionAproxRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    funcionAproximanteVal = funcionAproxParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    funcionAproximanteVal = funcionAproxExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    funcionAproximanteVal = funcionAproxPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    funcionAproximanteVal = funcionAproxHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  
  entornoFuncionAproximante = uibuttongroup (ventanaFuncionAproximante, "position", [ 0 0 1 1], ...
               "title","Función Aproximante","titleposition","centertop");
               

  funcionAprox = uicontrol (entornoFuncionAproximante,"style","text", ...
               "string",funcionAproximanteVal,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction

######                                                   
###   FUNCION APROXIMACION RECTA   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION PARABOLA   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 


######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 


###################################################################################
#                              DETALLE CALCULO                                    #
###################################################################################   

function detalleCalculo (ejeX,ejeY,cantDecimales,metodo)
  ventanaDetalleCalculo = figure;
  set (ventanaDetalleCalculo,"name","Aproximacion por minimos cuadrados");
  set (ventanaDetalleCalculo,"numbertitle","off");
  
  if (metodo == 1) #Recta
    detalleCalculoVal = detalleCalculoRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    detalleCalculoVal = detalleCalculoParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    detalleCalculoVal = detalleCalculoExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    detalleCalculoVal = detalleCalculoPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    detalleCalculoVal = detalleCalculoHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  
  entornoDetalleCalculo = uibuttongroup (ventanaDetalleCalculo, "position", [ 0 0 1 1], ...
               "title","Detalle cálculo","titleposition","centertop");
               

  detalleCalc = uicontrol (entornoDetalleCalculo,"style","text", ...
               "string",entornoDetalleCalculo,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction


######                                                   
###   DETALLE CALCULO RECTA   #####                      
##### 
function detalleCalculoRecta(ejeX,ejeY,cantDecimales)
  
endfunction
######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 


######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 


######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 


######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

###################################################################################
#                                  GRAFICO                                        #
################################################################################### 
  
function grafico (ejeX,ejeY,cantDecimales,metodo)
  ventanaGrafico = figure;
  set (ventanaGrafico,"name","Aproximacion por minimos cuadrados");
  set (ventanaGrafico,"numbertitle","off");
  
  if (metodo == 1) #Recta
    grafico = graficoRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    grafico = graficoParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    grafico = graficoExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    grafico = graficoPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    grafico = graficoHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  
  entornoGrafico = uibuttongroup (ventanaGrafico, "position", [ 0 0 1 1], ...
               "title","Grafico","titleposition","centertop");
               

  graficoFinal = uicontrol (entornoGrafico,"style","text", ...
               "string",grafico,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction


######                                                   
###   GRAFICO RECTA   #####                      
##### 


######                                                   
###   GRAFICO PARABOLA   #####                      
##### 


######                                                   
###   GRAFICO EXPONENCIAL   #####                      
##### 


######                                                   
###   GRAFICO POTENCIAL   #####                      
##### 


######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 



###################################################################################
#                          COMPARAR APROXIMACIONES                                #
###################################################################################
function abrirVentanaComAprox()
  endfunction
###################################################################################
#                                   FINALIZAR                                     #
###################################################################################
function cerrarVentana()
  endfunction

abrirVentanaPrincipal();
