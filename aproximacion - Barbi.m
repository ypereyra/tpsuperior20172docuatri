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
                 "position",[125,250,300,100],"callback",{@abrirVentanaAproximar}, ...
                 "backgroundcolor",[.8,.8,.8]);
                 
  botonFinalizar = uicontrol (entornoPrincipal,"string","Finalizar", ...
                 "position",[125,100,300,100],"callback",{@cerrarVentana}, ...
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
                {@opcionesAproxRecta,ejeX,ejeY,cantDecimales}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parábola de mínimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproxParabola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproxExponencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproxPotencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximación Hipérbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproxHiperbola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPCG = uicontrol (entornoSeleccionMetodos,"string","Comparar Aproximaciones", ...
                 "position",[150,50,250,60],"callback",{@abrirVentanaComAprox}, ...
                 "backgroundcolor",[.8,.8,.8]);
endfunction


###################################################################################
#                     RECTA DE MINIMOS CUADRADOS                                  #
###################################################################################

function opcionesAproxRecta (ejeX,ejeY,cantDecimales)
  ventanaOpcionesAproxRecta = figure;
  set (ventanaOpcionesAproxRecta,"name","Recta de mínimos cuadrados");
  set (ventanaOpcionesAproxRecta,"numbertitle","off");
  
  entornoOpcionesAproxRecta = uibuttongroup (ventanaOpcionesAproxRecta, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");

  botonFuncion = uicontrol (entornoOpcionesAproxRecta,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproxRecta,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproxRecta,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculoRecta,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproxRecta,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@graficoRecta,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

endfunction

######                                                   
###   FUNCION APROXIMACION RECTA   #####                      
##### 

function funcionAproxRecta(ejeX,ejeY,cantDecimales)
    funcionAproximante = ejeX;
    
    helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   DETALLE CALCULO RECTA   #####                      
##### 

function detalleCalculoRecta(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   GRAFICO RECTA   #####   
###### 
                 
function graficoRecta(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x=[0 2 3 6 7]; %eje x
  y=[0.120 0.153 0.171 0.225 0.260]; %eje y

  hold on 
  plot(x, y, 'o');
  P = polyfit(x, y, 1); 
  a = P(1); 
  b = P(2); 
  plot(x, a*x+b);
  
endfunction



###################################################################################
#                     PARABOLA DE MINIMOS CUADRADOS                               #
###################################################################################

function opcionesAproxParabola (ejeX,ejeY,cantDecimales)
  ventanaOpcionesAproxParabola = figure;
  set (ventanaOpcionesAproxParabola,"name","Parábola de mínimos cuadrados");
  set (ventanaOpcionesAproxParabola,"numbertitle","off");
  
  entornoOpcionesAproxParabola = uibuttongroup (ventanaOpcionesAproxParabola, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");

  botonFuncion = uicontrol (entornoOpcionesAproxParabola,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproxParabola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproxParabola,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculoParabola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproxParabola,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@graficoParabola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

endfunction

######                                                   
###   FUNCION APROXIMACION PARABOLA   #####                      
##### 

function funcionAproxParabola(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 

function detalleCalculoParabola(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   GRAFICO PARABOLA   #####   
###### 
                 
function graficoParabola(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x=[0 2 3 6 7]; %eje x
  y=[0.120 0.153 0.171 0.225 0.260]; %eje y

  hold on 
  plot(x, y, 'o'); 
  P = polyfit(x, y, 2)
  a = P(1) 
  b = P(2) 
  c = P(3) 
  plot(x, a*(x.^2)+b*x+c);

endfunction


###################################################################################
#                       APROXIMACION EXPONENCIAL                                  #
###################################################################################

function opcionesAproxExponencial (ejeX,ejeY,cantDecimales)
  ventanaOpcionesAproxExponencial = figure;
  set (ventanaOpcionesAproxExponencial,"name","Aproximación Exponencial");
  set (ventanaOpcionesAproxExponencial,"numbertitle","off");
  
  entornoOpcionesAproxExponencial = uibuttongroup (ventanaOpcionesAproxExponencial, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");

  botonFuncion = uicontrol (entornoOpcionesAproxExponencial,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproxExponencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproxExponencial,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculoExponencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproxExponencial,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@graficoExponencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

endfunction

######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 

function funcionAproxExponencial(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 

function detalleCalculoExponencial(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   GRAFICO EXPONENCIAL   #####   
###### 
                 
function graficoExponencial(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x=[0 2 3 6 7]; %eje x
  y=[0.120 0.153 0.171 0.225 0.260]; %eje y

  p=polyfit(x,log(y),1);
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  z=@(x) exp(p(2))*exp(x*p(1));
  fplot(z,[x(1),x(end)])
  xlabel('x')
  ylabel('y')
  grid on
  title('Regresión exponencial')
  hold off
  
endfunction



###################################################################################
#                       APROXIMACION POTENCIAL                                    #
###################################################################################

function opcionesAproxPotencial (ejeX,ejeY,cantDecimales)
  ventanaOpcionesAproxPotencial = figure;
  set (ventanaOpcionesAproxPotencial,"name","Aproximación Potencial");
  set (ventanaOpcionesAproxPotencial,"numbertitle","off");
  
  entornoOpcionesAproxPotencial = uibuttongroup (ventanaOpcionesAproxPotencial, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");

  botonFuncion = uicontrol (entornoOpcionesAproxPotencial,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproxPotencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproxPotencial,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculoPotencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproxPotencial,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@graficoPotencial,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

endfunction

######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 

function funcionAproxPotencial(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 

function detalleCalculoPotencial(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
endfunction

######                                                   
###   GRAFICO POTENCIAL   #####   
###### 
                 
function graficoPotencial(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x=[0 2 3 6 7]; %eje x
  y=[0.120 0.153 0.171 0.225 0.260]; %eje y

  p=polyfit(log10(x),log10(y),1);
  fprintf('exponente a= %2.3f\n',p(1));
  fprintf('coeficiente c = %3.3f\n',(10^p(2)));
   
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  z=@(x) (10^p(2))*x.^p(1);
  fplot(z,[x(1),x(end)])
  xlabel('x')
  ylabel('y')
  grid on
  title('Regresión potencial')
  hold off

endfunction


###################################################################################
#                       APROXIMACION HIPERBOLA                                    #
###################################################################################

function opcionesAproxHiperbola (ejeX,ejeY,cantDecimales)
  ventanaOpcionesAproxHiperbola = figure;
  set (ventanaOpcionesAproxHiperbola,"name","Aproximación Hipérbola");
  set (ventanaOpcionesAproxHiperbola,"numbertitle","off");
  
  entornoOpcionesAproxHiperbola = uibuttongroup (ventanaOpcionesAproxHiperbola, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");

  botonFuncion = uicontrol (entornoOpcionesAproxHiperbola,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproxHiperbola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproxHiperbola,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculoHiperbola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproxHiperbola,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@graficoHiperbola,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);

endfunction

######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 

function funcionAproxHiperbola(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

function detalleCalculoHiperbola(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
endfunction

######                                                   
###   GRAFICO HIPERBOLA   #####   
###### 
                 
function graficoHiperbola(ejeX,ejeY,cantDecimales)
  
endfunction

###################################################################################
#                          COMPARAR APROXIMACIONES                                #
###################################################################################

function abrirVentanaComAprox()
  
endfunction
  
###################################################################################
#                                   FINALIZAR                                     #
###################################################################################

function cerrarVentana()
  close;  
endfunction


abrirVentanaPrincipal();
