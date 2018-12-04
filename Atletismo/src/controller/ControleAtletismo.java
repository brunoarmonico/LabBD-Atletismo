package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Atleta;
import model.Resultado;
import model.ResultadoEvento;
import persistence.DBEvento;

/**
 * Servlet implementation class ControleAtletismo
 */
@WebServlet("/ControleAtletismo")
public class ControleAtletismo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ControlaEvento ctrEvento = new ControlaEvento();

	/**
	 * Default constructor.
	 */
	public ControleAtletismo() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//Opção selecionada nos botões da pagina
		String opcaoBtn = request.getParameter("botaoEnvio");
		String msgRetorno = null;
		
		//Click botão de adicionar novo atleta
		if ("novoAtleta".equals(opcaoBtn)) {
			Atleta atleta = new Atleta();
			atleta.setNome(request.getParameter("nome"));
			atleta.setCodigoPais(request.getParameter("pais"));
			atleta.setSexo(request.getParameter("sexo"));
			msgRetorno = ctrEvento.adicionarAtleta(atleta);
			request.getSession().removeAttribute("sucessoAtleta");
			request.getSession().removeAttribute("erroAtleta");
			if (msgRetorno.contains("SUCESSO") || msgRetorno.contains("Sucesso")) {
				request.getSession().setAttribute("sucessoAtleta", msgRetorno);
			} else {
				request.getSession().setAttribute("erroAtleta", msgRetorno);
			}
			response.sendRedirect("./novoatleta.jsp");
			
		// Click botão de adicionar novo resultado
		} else if ("novoResultado".equals(opcaoBtn)) {
			Resultado resultado = new Resultado();
			resultado.setId_atleta(Integer.parseInt(request.getParameter("codigo")));
			resultado.setId_Prova(Integer.parseInt(request.getParameter("prova")));
			resultado.setBateria(Integer.parseInt(request.getParameter("bateria")));
			resultado.setTempo(request.getParameter("tempo"));
			String distancia = request.getParameter("distancia");
			if (distancia.isEmpty()) {
				resultado.setDistancia(0);
			} else {
				resultado.setDistancia(Double.parseDouble(distancia));
			}
			resultado.setFase(request.getParameter("fase"));
			msgRetorno = ctrEvento.adicionarResultado(resultado);
			request.getSession().removeAttribute("sucessoResultado");
			request.getSession().removeAttribute("erroResultado");
			if (msgRetorno.contains("SUCESSO") || msgRetorno.contains("Sucesso")) {
				request.getSession().setAttribute("sucessoResultado", msgRetorno);
			} else {
				request.getSession().setAttribute("erroResultado", msgRetorno);
			}
			response.sendRedirect("./novoresultado.jsp");
			
		//Click botão de buscar resultados
		} else if ("buscaResultado".equals(opcaoBtn)) {
			Resultado resultado = new Resultado();
			resultado.setId_Prova((Integer.parseInt(request.getParameter("prova"))));
			resultado.setBateria(Integer.parseInt(request.getParameter("bateria")));
			resultado.setFase(request.getParameter("fase"));
			List<ResultadoEvento> lista = ctrEvento.listarResultados(resultado);
			request.getSession().setAttribute("listaRecord", ctrEvento.listarRecordes(resultado.getId_Prova()));
			request.getSession().removeAttribute("erro");
			if (lista != null && lista.size() > 0) {
				request.getSession().setAttribute("listaResultado", lista);
			} else {
				request.getSession().setAttribute("listaResultado", lista);
				request.getSession().setAttribute("erro",
						"Nenhum resultado encontrado para o evento, bateria ou fase.");
			}
			response.sendRedirect("./index.jsp");
			
			
		//Mover para a pagina "Novo Atleta" 
		} else if ("pgNovoAtleta".equals(opcaoBtn)) {
			request.getSession().removeAttribute("sucessoAtleta");
			request.getSession().removeAttribute("erroAtleta");
			response.sendRedirect("./novoatleta.jsp");
			
		//Mover para a pagina "Novo Resultado"
		} else if ("psNovoResultado".equals(opcaoBtn)) {
			request.getSession().removeAttribute("sucessoResultado");
			request.getSession().removeAttribute("erroResultado");
			response.sendRedirect("./novoresultado.jsp");
		}
	}
}
