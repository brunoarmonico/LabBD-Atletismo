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
	private ControlaEvento ce = new ControlaEvento();

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
		String opcao = request.getParameter("botaoEnvio");
		String retorno = null;
		if ("novoAtleta".equals(opcao)) {
			Atleta atleta = new Atleta();
			atleta.setNome(request.getParameter("nome"));
			atleta.setCodigoPais(request.getParameter("pais"));
			atleta.setSexo(request.getParameter("sexo"));
			retorno = ce.adicionarAtleta(atleta);
			response.sendRedirect("./novoatleta.jsp");
		} else if ("novoResultado".equals(opcao)) {
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
			retorno = ce.adicionarResultado(resultado);
			response.sendRedirect("./novoresultado.jsp");
		} else if ("buscaResultado".equals(opcao)) {
			Resultado resultado = new Resultado();
			resultado.setId_Prova((Integer.parseInt(request.getParameter("prova"))));
			resultado.setBateria(Integer.parseInt(request.getParameter("bateria")));
			resultado.setFase(request.getParameter("fase"));
			List<ResultadoEvento> lista = ce.listarResultados(resultado);
			if (lista != null && lista.size() > 0) {
				request.getSession().setAttribute("listaResultado", lista);
			} else {
				request.getSession().setAttribute("listaResultado", lista);
				request.getSession().setAttribute("erro", "Nenhum resultado encontrado.");
			}

			response.sendRedirect("./index.jsp");
		} else if ("pgNovoAtleta".equals(opcao)) {
			response.sendRedirect("./novoatleta.jsp");
		} else if ("psNovoResultado".equals(opcao)) {
			response.sendRedirect("./novoresultado.jsp");
		}
	}
}
