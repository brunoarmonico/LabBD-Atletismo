package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Atleta;
import model.Pais;
import model.Prova;
import model.Resultado;

public class DBEvento implements IBDEvento{

	@Override
	public String novoAtleta(Atleta atleta) {
		Connection con = DBUtil.getInstance().getConnection();
		String query = "{call pr_adicionaAtleta (?, ?, ?, ?)}";
		String saida = null;
		try {
			System.out.println(atleta.getNome()+ " - " +atleta.getSexo());
			CallableStatement cs = con.prepareCall(query);
			cs.setString(1, atleta.getNome());
			cs.setString(2, atleta.getSexo());
			cs.setString(3, atleta.getCodigoPais());
			cs.registerOutParameter(4, Types.VARCHAR);
			cs.execute();
			saida = (cs.getString(4));
			cs.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return saida;
	}

	@Override
	public String novoResultadoEvento(Resultado resultado) {
		Connection con = DBUtil.getInstance().getConnection();
		String query = "{call pr_adicionaResultado (?, ?, ?, ?, ?, ?, ?)}";
		String saida = null;
		
		try {
			
			CallableStatement cs = con.prepareCall(query);
			cs.setInt(1, resultado.getId_Prova());
			cs.setInt(2, resultado.getId_atleta());
			cs.setTime(3, resultado.getTempo());
			cs.setInt(4, resultado.getBateria());
			cs.setDouble(5, resultado.getDistancia());
		    cs.setString(6, resultado.getFase());
		    cs.execute();
		    saida = (cs.getString(7));
		    cs.close();
			
		} catch (Exception e){
			
			System.out.println("Erro");
		}
		return saida;
	}

	@Override
	public List<Prova> recebeProva() {
		
		Connection con = DBUtil.getInstance().getConnection();
		String query = "select * from fn_retorna_prova()";
		List<Prova> lista = new ArrayList<Prova>();
		
		try {
			
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Prova prova = new Prova();
				prova.setIdProva(rs.getInt("id_prova"));
				prova.setNomeProva(rs.getString("nome_prova"));
				prova.setSexo(rs.getString("sexo"));
				lista.add(prova);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return lista;
	}

	@Override
	public List<Pais> recebeListaPaises() {
		Connection con = DBUtil.getInstance().getConnection();
		String query = "select * from fn_lista_pais()";
		List<Pais> lista = new ArrayList<Pais>();
		
		try {
			
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Pais pais = new Pais();
				pais.setNome(rs.getString("nome"));
				pais.setCodigo(rs.getString("codigo"));
				lista.add(pais);
			}
		} catch (Exception e){
			
			System.out.println("Erro");
		}
		return lista;
	}
}
