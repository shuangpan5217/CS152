package edu.sjsu.fwjs;

import java.util.ArrayList;
import java.util.List;

import edu.sjsu.fwjs.parser.FeatherweightJavaScriptBaseVisitor;
import edu.sjsu.fwjs.parser.FeatherweightJavaScriptParser;
import edu.sjsu.fwjs.parser.FeatherweightJavaScriptParser.ExprContext;

import org.antlr.v4.runtime.tree.TerminalNode;

public class ExpressionBuilderVisitor extends FeatherweightJavaScriptBaseVisitor<Expression>{
    @Override
    public Expression visitProg(FeatherweightJavaScriptParser.ProgContext ctx) {
        List<Expression> stmts = new ArrayList<Expression>();
        for (int i=0; i<ctx.stat().size(); i++) {
            Expression exp = visit(ctx.stat(i));
            if (exp != null) stmts.add(exp);
        }
        return listToSeqExp(stmts);
    }

    @Override
    public Expression visitBareExpr(FeatherweightJavaScriptParser.BareExprContext ctx) {
        return visit(ctx.expr());
    }

    /* IF, WHILE, PRINT */
    @Override
    public Expression visitIfThenElse(FeatherweightJavaScriptParser.IfThenElseContext ctx) {
        Expression cond = visit(ctx.expr());
        Expression thn = visit(ctx.block(0));
        Expression els = visit(ctx.block(1));
        return new IfExpr(cond, thn, els);
    }

    @Override
    public Expression visitIfThen(FeatherweightJavaScriptParser.IfThenContext ctx) {
        Expression cond = visit(ctx.expr());
        Expression thn = visit(ctx.block());
        return new IfExpr(cond, thn, null);
    }
    
    @Override
    public Expression visitWhile(FeatherweightJavaScriptParser.WhileContext ctx) {
        Expression cond = visit(ctx.expr());
        Expression body = visit(ctx.block());
        return new WhileExpr(cond, body);
    }
    
    @Override
    public Expression visitPrint(FeatherweightJavaScriptParser.PrintContext ctx) {
        Expression expr = visit(ctx.expr());
        return new PrintExpr(expr);
    }

    public Expression visitMulDivMod(FeatherweightJavaScriptParser.MulDivModContext ctx) {
        Expression left = visit(ctx.expr(0));
        Expression right = visit(ctx.expr(1));
        Op operator = getOperator(String.valueOf(ctx.op.getText()));
        return new BinOpExpr(operator, left, right);
    }
    
    public Expression visitAddSub(FeatherweightJavaScriptParser.AddSubContext ctx) {
        Expression left = visit(ctx.expr(0));
        Expression right = visit(ctx.expr(1));
        Op operator = getOperator(String.valueOf(ctx.op.getText()));
        return new BinOpExpr(operator, left, right);
    }
    
    public Expression visitComparision(FeatherweightJavaScriptParser.ComparisionContext ctx) {
        Expression left = visit(ctx.expr(0));
        Expression right = visit(ctx.expr(1));
        Op operator = getOperator(String.valueOf(ctx.op.getText()));
        return new BinOpExpr(operator, left, right);
    }

    /* Literals */
    @Override
    public Expression visitInt(FeatherweightJavaScriptParser.IntContext ctx) {
        int val = Integer.valueOf(ctx.INT().getText());
        return new ValueExpr(new IntVal(val));
    }

    @Override
    public Expression visitParens(FeatherweightJavaScriptParser.ParensContext ctx) {
        return visit(ctx.expr());
    }
    
    @Override
    public Expression visitBoolean(FeatherweightJavaScriptParser.BooleanContext ctx) {
        boolean bool = Boolean.valueOf(ctx.BOOL().getText());
        return new ValueExpr(new BoolVal(bool));
    }
    
    @Override
    public Expression visitNil(FeatherweightJavaScriptParser.NilContext ctx) {
        return new ValueExpr(new NullVal());
    }
    
    @Override
    public Expression visitVarDel(FeatherweightJavaScriptParser.VarDelContext ctx) {
        String name = String.valueOf(ctx.ID().getText());
        Expression expr = visit(ctx.expr());
        return new VarDeclExpr(name, expr);
    }
    
    @Override
    public Expression visitAssign(FeatherweightJavaScriptParser.AssignContext ctx) {
        String name = String.valueOf(ctx.ID().getText());
        Expression expr = visit(ctx.expr());
        return new AssignExpr(name, expr);
    }
    
    @Override
    public Expression visitVarRef(FeatherweightJavaScriptParser.VarRefContext ctx) {
        String name = String.valueOf(ctx.ID().getText());
        return new VarExpr(name);
    }

    public Expression visitFunction(FeatherweightJavaScriptParser.FunctionContext ctx) {
        List<String> parameters = new ArrayList<String>();
        
        List<TerminalNode> list = ctx.ID();

        for(int i = 0; i < list.size(); i++) {
            parameters.add(String.valueOf(list.get(i)));
        }
        
        Expression body = visit(ctx.block());
        return new FunctionDeclExpr(parameters, body);
    }
    
    public Expression visitFunctionAPP(FeatherweightJavaScriptParser.FunctionAPPContext ctx) {
        Expression expr = visit(ctx.expr(0));

        List<Expression> args = new ArrayList<Expression>();
        
        List<ExprContext> list = ctx.expr();

        for(int i = 1; i < list.size(); i++) {
            args.add(visit(list.get(i)));
        }
        
        return new FunctionAppExpr(expr, args);
    }

    @Override
    public Expression visitFullBlock(FeatherweightJavaScriptParser.FullBlockContext ctx) {
        List<Expression> stmts = new ArrayList<Expression>();
        for (int i=1; i<ctx.getChildCount()-1; i++) {
            Expression exp = visit(ctx.getChild(i));
            stmts.add(exp);
        }
        return listToSeqExp(stmts);
    }

    public Op getOperator(String value) {     
        switch(value) {
        case "+":
            return Op.ADD;
        case "-":
            return Op.SUBTRACT;
        case "*":
            return Op.MULTIPLY;
        case "/":
            return Op.DIVIDE;
        case "%":
            return Op.MOD;
        case ">":
            return Op.GT;
        case ">=":
            return Op.GE;
        case "<":
            return Op.LT;
        case "<=":
            return Op.LE;
        case "==":
            return Op.EQ;
        default:
            return null;
        }
    }

    /**
     * Converts a list of expressions to one sequence expression,
     * if the list contained more than one expression.
     */
    private Expression listToSeqExp(List<Expression> stmts) {
        if (stmts.isEmpty()) return null;
        Expression exp = stmts.get(0);
        for (int i=1; i<stmts.size(); i++) {
            exp = new SeqExpr(exp, stmts.get(i));
        }
        return exp;
    }

    @Override
    public Expression visitSimpBlock(FeatherweightJavaScriptParser.SimpBlockContext ctx) {
        return visit(ctx.stat());
    }
}
