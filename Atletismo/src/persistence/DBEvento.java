package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Atleta;
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
			CallableStatement ps = con.prepareCall(query);
			ps.setString(1, atleta.getNome());
			ps.setString(2, atleta.getSexo());
			ps.setString(3, atleta.getCodigoPais());
			ps.registerOutParameter(4, Types.VARCHAR);
			ps.execute();
			saida = (ps.getString(4));
			ps.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return saida;
	}

	@Override
	public String novoResultadoEvento(Resultado resultado) {
		// TODO Auto-generated method stub
		return null;
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

}
