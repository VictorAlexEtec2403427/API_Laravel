<?php
    namespace App\Http\Controllers\Api;


    use App\Models\Produto;

    use Illuminate\Http\Request;

    use App\Http\Controllers\Controller;


    class ProdutoController extends Controller

    {

        // Listar todos os produtos

        public function index()

        {

            $produtos = Produto::all();

            return response()->json($produtos);

        }


        // Criar novo produto

        public function store(Request $request)

        {

            $request->validate([

                'nome' => 'required|string|max:100',

                'preco' => 'required|numeric|min:0',

                'quantidade' => 'integer|min:0',

                'descricao' => 'nullable|string'

            ]);


            $produto = Produto::create($request->all());

            return response()->json($produto, 201);

        }


        // Exibir um produto específico

        public function show($id)

        {

            $produto = Produto::find($id);

            if(!$produto) {

                return response()->json(['message' => 'Produto não encontrado'], 404);

            }

            return response()->json($produto);

        }


        // Atualizar produto

        public function update(Request $request, $id)

        {

            $produto = Produto::find($id);

            if(!$produto) {

                return response()->json(['message' => 'Produto não encontrado'], 404);

            }


            $request->validate([

                'nome' => 'sometimes|string|max:100',

                'preco' => 'sometimes|numeric|min:0',

                'quantidade' => 'sometimes|integer|min:0',

                'descricao' => 'nullable|string'

            ]);


            $produto->update($request->all());

            return response()->json($produto);

        }


        // Deletar produto

        public function destroy($id)

        {

            $produto = Produto::find($id);

            if(!$produto) {

                return response()->json(['message' => 'Produto não encontrado'], 404);

            }

            $produto->delete();

            return response()->json(['message' => 'Produto removido com sucesso']);

        }

    }