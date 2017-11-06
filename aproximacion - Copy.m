pkg load control;
pkg load signal;

######                                                   
###   VENTANA PRINCIPAL   #####                      
#####
function abrirVentanaPrincipal ()
  ventanaPrincipal = figure;
  set (ventanaPrincipal,"name","AMIC - Aproximación por Mí­nimos Cuadrados");
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
               "title","Establezca los puntos y elija su aproximacion\n en forma de una matriz de n*2 siendo n\nlacantidad de puntos y cada fila un punto",...
               "titleposition","centertop");
               
  textoPuntos = uicontrol (entornoAproximar,"style","text", ...
               "string","Escriba los puntos ","position",[100,300,300,40], ... 
               "fontsize",16);
  puntos = uicontrol (entornoAproximar, "style", "edit", ...
    "string", "1.2,1.06;2.1,2.14;2.8,3.23;3.1,3.8;3.5,4.7;4.1,6.3;4.4,7.33;4.9,9.48;5.6,13.98;5.9,16.56;6.2,20.23;6.5,25.45",...
    "position",[10,250,500,40], ...
     "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
  
  #entornoAproximar = uibuttongroup (ventanaAproximar, "position", [ 0 0 1 1], ...
   #            "title","Establezca los puntos y elija su aproximacion","titleposition","centertop");
               
  #textoEjeX = uicontrol (entornoAproximar,"style","text", ...
   #            "string","eje x:","position",[100,350,300,40], ... 
    #           "fontsize",16);
  #ejeX = uicontrol (entornoAproximar, "style", "edit", ...
   #            "string", "2,7,4", "position",[120,310,290,40], ...
    #           "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  #textoEjeY = uicontrol (entornoAproximar,"style","text", ...
   #            "string","Eje y :","position",[100,250,300,40], ... 
    #           "fontsize",16);  
  #ejeY = uicontrol (entornoAproximar, "style", "edit", ...
   #            "string", "6,1,9,3", "position",[120,210,290,40], ...
    #           "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  textoCantDecimales = uicontrol (entornoAproximar,"style","text", ...
               "string","Cantidad decimales:","position",[100,150,300,40], ... 
               "fontsize",16);
               
  cantDecimales = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "6,1,9,3", "position",[120,110,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
               "position",[150,50,200,40],"callback",...
                {@seleccionMetodos,puntos}, ...             
               "backgroundcolor",[.8,.8,.8]);
               
  #botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
   #            "position",[150,50,200,40],"callback",...
    #            {@seleccionMetodos,ejeX,ejeY,cantDecimales}, ...             
     #          "backgroundcolor",[.8,.8,.8]);
  
endfunction


######                                                   
###   SELECCION METODOS   #####                      
#####  
function seleccionMetodos (handlesource,event,puntos)
  ventanaSeleccionMetodos = figure;
  set (ventanaSeleccionMetodos,"name","Aproximación por mínimos cuadrados");
  set (ventanaSeleccionMetodos,"numbertitle","off");
  
  entornoSeleccionMetodos = uibuttongroup (ventanaSeleccionMetodos, "position", [ 0 0 1 1], ...
               "title","Elija el método de aproximación","titleposition","centertop");
               
               
  botonRecta = uicontrol (entornoSeleccionMetodos,"string"," Recta de mí­nimos cuadrados", ...
               "position",[150,350,250,30],"callback",...
                {@opcionesAproximacion,puntos,1}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parábola de mínimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproximacion,puntos,2}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproximacion,puntos,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,puntos,4}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximación Hipérbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,puntos,5}, ...
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


######                                                   
###   OPCIONES APROXIMACION   #####                      
##### 
function opcionesAproximacion (handlesource,event,puntos,metodo)
  ventanaOpcionesAproximacion = figure;
  set (ventanaOpcionesAproximacion,"name","Aproximación por mínimos cuadrados");
  set (ventanaOpcionesAproximacion,"numbertitle","off");
  
  entornoOpcionesAproximacion = uibuttongroup (ventanaOpcionesAproximacion, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");
               

  botonFuncion = uicontrol (entornoOpcionesAproximacion,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproximante,puntos,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproximacion,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculo,puntos,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproximacion,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@grafico,puntos,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
  
endfunction


###################################################################################
#                            FUNCION APROXIMANTE                                  #
###################################################################################

function funcionAproximante (handlesource,event,puntos,metodo)
  #ventanaFuncionAproximante = figure;
  #set (ventanaFuncionAproximante,"name","Aproximacion por minimos cuadrados");
  #set (ventanaFuncionAproximante,"numbertitle","off");
  
  if (metodo == 1) #Recta
    funcionAproximanteVal = funcionAproxRecta(puntos)
  elseif (metodo == 2) #Parabola
    funcionAproximanteVal = funcionAproxParabola(puntos)
  elseif (metodo == 3) #Exponencial
    funcionAproximanteVal = funcionAproxExponencial(puntos)
  elseif (metodo == 4) #Potencial
    funcionAproximanteVal = funcionAproxPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    funcionAproximanteVal = funcionAproxHiperbola(puntos)
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
 
function funcionAproxRecta(puntos) 
 h=recta(get (puntos,"string"));

 helpdlg (strcat("y=",num2str(h(1)),"x +",num2str(h(2))),"recta minimo cuadrado");
     
endfunction
   
function x = recta(puntos)
  # sea ax+b en el vector se guarda a,b
  matri=str2num(puntos);
  cantidadPuntos = length(matri);
  sumX=sum(matri(:,1));
  sumY=sum(matri(:,2));
  sumXY=0;
  sumX2=0;  #sumatoria de x^2
  
  for i=1:cantidadPuntos
   sumXY = sumXY + matri(i,1)*matri(i,2);
   sumX2=sumX2 + matri(i,1)^2 ;
  endfor
  
  A= [sumX2,sumX;sumX,cantidadPuntos];
  b=[sumXY;sumY];
  Ai=inv(A);
  x=Ai*b;
   
endfunction

######                                                   
###   FUNCION APROXIMACION PARABOLA   #####                      
##### 

function funcionAproxParabola(puntos)
    
  funcionAproximante = puntos;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 

function funcionAproxExponencial(puntos)
    
  funcionAproximante = puntos;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 

function funcionAproxPotencial(puntos)
    
  funcionAproximante = puntos;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 

function funcionAproxHiperbola(puntos)
    
  funcionAproximante = puntos;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

###################################################################################
#                              DETALLE CALCULO                                    #
###################################################################################   

function detalleCalculo (handlesource,event,puntos,metodo) 
 # ventanaDetalleCalculo = figure;
 # set (ventanaDetalleCalculo,"name","Aproximacion por minimos cuadrados");
 # set (ventanaDetalleCalculo,"numbertitle","off");
  
  if (metodo == 1) #Recta
    detalleCalculoVal = detalleCalculoRecta(puntos)
  elseif (metodo == 2) #Parabola
    detalleCalculoVal = detalleCalculoParabola(puntos)
  elseif (metodo == 3) #Exponencial
    detalleCalculoVal = detalleCalculoExponencial(puntos)
  elseif (metodo == 4) #Potencial
    detalleCalculoVal = detalleCalculoPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    detalleCalculoVal = detalleCalculoHiperbola(puntos)
  endif
 
  entornoDetalleCalculo = uibuttongroup (ventanaDetalleCalculo, "position", [ 0 0 1 1], ...
               "title","Detalle cÃ¡lculo","titleposition","centertop");
               
  detalleCalc = uicontrol (entornoDetalleCalculo,"style","text", ...
               "string",entornoDetalleCalculo,"position",[100,250,300,40], ... 
               "fontsize",16);
               
endfunction
#matri(1,1) es el numero de la 1era fila y 1era columna


######                                                   
###   DETALLE CALCULO RECTA   #####                
function detalleCalculoRecta(puntos)
  h= get (puntos,"string");
  matri=str2num(h);
  cantidadPuntos = length(matri);
  str= "\ni \t\t xi \t\t yi\t\t xi^2\t\t xi.yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t\t",num2str(matri(i,1)),"\t\t",num2str(matri(i,2)),"\t\t",num2str(matri(i,1)^2),"\t\t",num2str(matri(i,1)*matri(i,2))," \n");
  endfor
  sumX =sum(matri(:,1));
  sumY =sum(matri(:,2));
  sumXY=0;
  sumX2=0;  #sumatoria de x^2
  for i=1:cantidadPuntos
    sumXY = sumXY + matri(i,1)*matri(i,2);
    sumX2=sumX2 + matri(i,1)^2 ;
  endfor 
       
  str=strcat(str,"\t\t",num2str(sumX),"\t\t",num2str(sumY),"\t\t",num2str(sumX2),"\t\t",num2str(sumXY),"\n\n");
  h=recta(get (puntos,"string")); #S
  str=strcat(str,"El sistema planteado es\n\n",...
       "a *",num2str(sumX2),"\t","+","\t","b *",num2str(sumX),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX),"\t\t","+","\t","b *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "resolviendo el sistema queda\n\n","a =",num2str(h(1)),"\n","b =",num2str(h(2)),"\n",...
       num2str(h(1)),"X + ",num2str(h(2)),"\n");
       
  helpdlg (evalc ("str"),"detalle del calculo");
endfunction      
##### 

######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 

function detalleCalculoParabola(puntos)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 

function detalleCalculoExponencial(puntos)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 

function detalleCalculoPotencial(puntos)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
endfunction

######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

function detalleCalculoHiperbola(puntos)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
endfunction

###################################################################################
#                                  GRAFICO                                        #
################################################################################### 
  
function grafico (handlesource,event,puntos,metodo)
  #ventanaGrafico = figure;
  #set (ventanaGrafico,"name","Aproximacion por minimos cuadrados");
  #set (ventanaGrafico,"numbertitle","off");
  
  if (metodo == 1) #Recta
    grafico = graficoRecta(puntos)
  elseif (metodo == 2) #Parabola
    grafico = graficoParabola(puntos)
  elseif (metodo == 3) #Exponencial
    grafico = graficoExponencial(puntos)
  elseif (metodo == 4) #Potencial
    grafico = graficoPotencial(puntos)
  elseif (metodo == 5) #Hiperbola
    grafico = graficoHiperbola(puntos)
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

function graficoRecta(puntos) 
  h=recta(get (puntos,"string"));
  grafi =figure
  set (grafi,"name","Grafico de la recta");
  set (grafi,"numbertitle","off");
  x=[1:0.1:7];
  y=h(1)*x + h(2);
  plot(x,y)
   
  #grafico = figure;
  #set (grafico,"name","Gráfica de la función");
  #set (grafico,"numbertitle","off");
  
  #x=[0 2 3 6 7]; %eje x
  #y=[0.120 0.153 0.171 0.225 0.260]; %eje y

  #hold on 
  #plot(x, y, 'o');
  #P = polyfit(x, y, 1); 
  #a = P(1); 
  #b = P(2); 
  #plot(x, a*x+b);
   
endfunction

######                                                   
###   GRAFICO PARABOLA   #####                      
##### 

function graficoParabola(puntos)
  
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

######                                                   
###   GRAFICO EXPONENCIAL   #####                      
##### 

function graficoExponencial(puntos)
  
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

######                                                   
###   GRAFICO POTENCIAL   #####                      
##### 

function graficoPotencial(puntos)
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

######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 

function graficoHiperbola(puntos)
  
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

             
