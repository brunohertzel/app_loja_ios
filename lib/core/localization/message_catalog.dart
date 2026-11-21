// App-owned interface messages. Server catalog and legal documents stay verbatim.
class MessageCatalog {
  static const Map<String, List<String>> messages = {
    // REV5 - GPS: cidade pode vir do CEP ou exigir correção manual.
    'A localização não identificou a cidade. Informe a cidade e confira o endereço antes de salvar.': [
      'Your location did not identify the city. Enter the city and check the address before saving.',
      'La ubicación no identificó la ciudad. Indique la ciudad y revise la dirección antes de guardar.'
    ],
    // REV4 - Redes sociais e vitrine continua (EN, ES).
    'Siga a loja': ['Follow the store', 'Sigue la tienda'],
    'Redes sociais da desenvolvedora': ['Developer social media', 'Redes sociales de la desarrolladora'],
    'Todos os produtos': ['All products', 'Todos los productos'],
    'Carregar mais produtos': ['Load more products', 'Cargar más productos'],
    // Android REV3: endereco por GPS e favoritos — 3 idiomas.
    "Permissão de localização bloqueada. Autorize nos Ajustes do iPhone ou digite o endereço.": [
      "Location permission is blocked. Enable it in iPhone Settings or enter the address manually.",
      "El permiso de ubicación está bloqueado. Actívelo en los ajustes del iPhone o escriba la dirección."
    ],

    "Não foi possível obter a localização agora. Você pode digitar o endereço manualmente.": [
      "Could not get your location right now. You can enter the address manually.",
      "No se pudo obtener su ubicación ahora. Puede ingresar la dirección manualmente."
    ],
    "Usar minha localização atual": ["Use my current location", "Usar mi ubicación actual"],
    "Sugere rua e número aproximados. Você pode corrigir tudo antes de salvar.": [
      "Suggests a nearby street and house number. You can edit everything before saving.",
      "Sugiere una calle y un número aproximados. Puede corregir todo antes de guardar."
    ],
    "Usar endereço aproximado?": ["Use approximate address?", "¿Usar dirección aproximada?"],
    "A localização pode sugerir o número da rua. Confira e corrija o número, CEP e complemento antes de salvar.": [
      "Your location may suggest a street number. Check and correct the number, postal code and apartment or unit before saving.",
      "La ubicación puede sugerir un número de calle. Revise y corrija el número, código postal y complemento antes de guardar."
    ],
    "Usar e ajustar": ["Use and edit", "Usar y corregir"],
    "Número aproximado": ["Approximate number", "Número aproximado"],
    "Número {0} sugerido pelo GPS: confirme ou corrija antes de salvar.": [
      "GPS suggested house number {0}: confirm or correct it before saving.",
      "El GPS sugirió el número {0}: confírmelo o corríjalo antes de guardar."
    ],
    "Localização aproximada preenchida. Informe o número e confira os demais campos.": [
      "Approximate location filled in. Enter your house number and check the other fields.",
      "Ubicación aproximada completada. Indique el número y revise los demás campos."
    ],
    "Ative a localização do aparelho para preencher o endereço.": [
      "Turn on location services to fill in the address.",
      "Active la ubicación del dispositivo para completar la dirección."
    ],
    "Permissão de localização bloqueada. Autorize nas configurações do Android ou digite o endereço.": [
      "Location permission is blocked. Enable it in Android Settings or enter the address manually.",
      "El permiso de ubicación está bloqueado. Actívelo en la configuración de Android o escriba la dirección."
    ],
    "Localização não autorizada. Você pode cadastrar o endereço manualmente.": [
      "Location was not allowed. You can enter the address manually.",
      "No se autorizó la ubicación. Puede ingresar la dirección manualmente."
    ],
    "Não foi possível identificar o endereço próximo. Preencha manualmente.": [
      "Could not identify a nearby address. Enter it manually.",
      "No se pudo identificar una dirección cercana. Escríbala manualmente."
    ],
    "A localização retornou um endereço fora do Brasil. Confira o endereço manualmente.": [
      "Location returned an address outside Brazil. Please check the address manually.",
      "La ubicación devolvió una dirección fuera de Brasil. Revise la dirección manualmente."
    ],
    "A localização não retornou dados de endereço. Digite manualmente.": [
      "No address data was returned for your location. Enter it manually.",
      "La ubicación no devolvió datos de dirección. Ingréselos manualmente."
    ],
    "Meus itens favoritos": ["My favorite items", "Mis artículos favoritos"],
    "Seus produtos favoritos aparecerão aqui.": [
      "Your favorite products will appear here.",
      "Tus productos favoritos aparecerán aquí."
    ],
    "Carrinho atualizado.": ["Cart updated.", "Carrito actualizado."],
    "Tipo de conta": ["Account type", "Tipo de cuenta"],
    "Razão social": ["Legal business name", "Razón social"],
    "Nome fantasia (opcional)": [
      "Trading name (optional)",
      "Nombre comercial (opcional)"
    ],
    "Inscrição estadual (opcional)": [
      "State tax registration (optional)",
      "Inscripción estatal (opcional)"
    ],
    "Contas CNPJ precisam de aprovação comercial da loja.": [
      "CNPJ accounts require commercial approval from the store.",
      "Las cuentas CNPJ necesitan la aprobación comercial de la tienda."
    ],
    "Cadastro recebido": ["Registration received", "Registro recibido"],
    "Cadastro CNPJ recebido. Sua conta está em análise comercial. Aguarde a liberação da loja.":
        [
      "CNPJ registration received. Your account is under commercial review. Please wait for approval from the store.",
      "Registro CNPJ recibido. Su cuenta está en revisión comercial. Espere la aprobación de la tienda."
    ],
    "Informe nome, CPF/CNPJ e e-mail corretamente.": [
      "Enter your name, CPF/CNPJ and email correctly.",
      "Ingrese correctamente el nombre, CPF/CNPJ y correo electrónico."
    ],
    "Este CPF/CNPJ já está cadastrado.": [
      "This CPF/CNPJ is already registered.",
      "Este CPF/CNPJ ya está registrado."
    ],
    "Informe um CPF com 11 dígitos ou CNPJ com 14 dígitos.": [
      "Enter an 11-digit CPF or a 14-digit CNPJ.",
      "Ingrese un CPF de 11 dígitos o un CNPJ de 14 dígitos."
    ],
    "CEP regional: selecione o Bairro / Balneário / Distrito e informe Rua e Número.":
        [
      "Regional postal code: select the Neighborhood / Beach locality / District and enter Street and Number.",
      "Código postal regional: seleccione el Barrio / Balneario / Distrito e indique Calle y Número."
    ],
    "Esta cidade ainda não possui localidades ativas configuradas. O endereço pode ser cadastrado; a entrega será validada no checkout.":
        [
      "This city has no active delivery areas configured yet. You can save the address; delivery eligibility will be checked at checkout.",
      "Esta ciudad aún no tiene localidades activas configuradas. Puede guardar la dirección; la entrega se validará al finalizar la compra."
    ],
    "Consulta de CEP indisponível. Confira Rua, Número, Bairro, Cidade e UF antes de salvar.":
        [
      "Postal code lookup is unavailable. Check Street, Number, Neighborhood, City and State before saving.",
      "La consulta del código postal no está disponible. Revise Calle, Número, Barrio, Ciudad y Estado antes de guardar."
    ],
    "Reabra a página e tente novamente.": [
      "Reopen the page and try again.",
      "Vuelva a abrir la página e inténtelo nuevamente."
    ],
    "O cadastro foi atualizado. Reabra a página.": [
      "The account was updated. Reopen the page.",
      "El registro se actualizó. Vuelva a abrir la página."
    ],
    "Informe um CEP com 8 dígitos.": [
      "Enter an 8-digit postal code.",
      "Ingrese un código postal de 8 dígitos."
    ],
    "Informe uma identificação de até 100 caracteres.": [
      "Enter an address label of up to 100 characters.",
      "Ingrese una identificación de hasta 100 caracteres."
    ],
    "Não foi possível consultar o CEP. Preencha o endereço completo e consulte as localidades.":
        [
      "Postal code lookup failed. Enter the full address and look up delivery areas.",
      "No fue posible consultar el código postal. Complete la dirección y consulte las localidades."
    ],
    "Código da cidade inválido. Consulte o CEP novamente.": [
      "Invalid city code. Look up the postal code again.",
      "Código de ciudad inválido. Consulte nuevamente el código postal."
    ],
    "Consultar CEP": ["Look up postal code", "Consultar código postal"],
    "Consultar localidades": [
      "Look up delivery areas",
      "Consultar localidades"
    ],
    "Consultando localidades...": [
      "Loading delivery areas...",
      "Consultando localidades..."
    ],
    "Bairro / Balneário / Distrito": [
      "Neighborhood / Beach locality / District",
      "Barrio / Balneario / Distrito"
    ],
    "Selecione o Bairro / Balneário / Distrito.": [
      "Select the neighborhood, beach locality or district.",
      "Seleccione el Barrio / Balneario / Distrito."
    ],
    "CEP regional: selecione a localidade e informe Rua e Número.": [
      "Regional postal code: select the locality and enter the street and number.",
      "Código postal regional: seleccione la localidad e informe Calle y Número."
    ],
    "Cidade fora da área atendida. O endereço pode ser salvo, mas não poderá ser usado para entrega.":
        [
      "City outside the delivery area. You can save the address, but it cannot be used for delivery.",
      "Ciudad fuera del área atendida. Puede guardar la dirección, pero no podrá usarla para entrega."
    ],
    "Esta cidade está atendida, mas ainda não possui localidades ativas configuradas.":
        [
      "This city is served, but no active localities are configured yet.",
      "Esta ciudad está atendida, pero aún no tiene localidades activas configuradas."
    ],
    "A localidade selecionada não está disponível para esta cidade.": [
      "The selected locality is not available for this city.",
      "La localidad seleccionada no está disponible para esta ciudad."
    ],
    "Endereço salvo, mas indisponível para entrega. Escolha outro endereço ou retirada.":
        [
      "Address saved, but unavailable for delivery. Choose another address or pickup.",
      "Dirección guardada, pero no disponible para entrega. Elija otra dirección o recogida."
    ],
    "Atualize o motor de frete por localidade da loja.": [
      "Update the store locality delivery engine.",
      "Actualice el motor de envío por localidad de la tienda."
    ],
    "Configure as localidades de entrega no Admin da loja.": [
      "Configure delivery localities in the store administration.",
      "Configure las localidades de entrega en la administración de la tienda."
    ],
    "Atualize a estrutura de localidades de entrega da loja.": [
      "Update the store delivery locality structure.",
      "Actualice la estructura de localidades de entrega de la tienda."
    ],
    "Não foi possível consultar o CEP. Informe o endereço e consulte as localidades.":
        [
      "Could not look up the postal code. Enter the address and look up delivery areas.",
      "No se pudo consultar el código postal. Informe la dirección y consulte las localidades."
    ],
    "Não foi possível consultar as localidades cadastradas.": [
      "Could not load the configured delivery areas.",
      "No se pudieron consultar las localidades registradas."
    ],
    "Esta cidade não está configurada para frete por localidade.": [
      "This city is not configured for delivery by locality.",
      "Esta ciudad no está configurada para envío por localidad."
    ],
    "O bairro deste endereço não está entre as localidades atendidas.": [
      "This address neighborhood is outside the served localities.",
      "El barrio de esta dirección no está entre las localidades atendidas."
    ],
    "Selecione o Bairro / Balneário / Distrito para calcular o frete.": [
      "Select the neighborhood, beach locality or district to calculate delivery.",
      "Seleccione el Barrio / Balneario / Distrito para calcular el envío."
    ],
    "Endereço selecionado inválido.": [
      "Invalid selected address.",
      "Dirección seleccionada no válida."
    ],
    "Código da cidade inválido.": [
      "Invalid city code.",
      "Código de ciudad no válido."
    ],
    "Não foi possível localizar a Rua/Avenida deste CEP regional pelo motor de frete.":
        [
      "The delivery engine could not locate the street for this regional postal code.",
      "El motor de envío no pudo localizar la Calle/Avenida de este código postal regional."
    ],
    "Não foi possível localizar este endereço pelo motor de frete.": [
      "The delivery engine could not locate this address.",
      "El motor de envío no pudo localizar esta dirección."
    ],
    "Calculando frete...": ["Calculating delivery...", "Calculando envío..."],
    "Desativar notificações": [
      "Disable notifications",
      "Desactivar notificaciones"
    ],
    "MMAA": ["MMYY", "MMAA"],
    "{0} está licenciado, mas foi desabilitado no configurador do módulo Mobile.":
        [
      "{0} is licensed but was disabled in the Mobile module settings.",
      "{0} tiene licencia, pero se desactivó en la configuración del módulo Mobile."
    ],
    "{0} não está incluído na licença do módulo Soft Ecommerce Mobile.": [
      "{0} is not included in the Soft Ecommerce Mobile license.",
      "{0} no está incluido en la licencia de Soft Ecommerce Mobile."
    ],
    "Esta versão do aplicativo precisa ser atualizada. Versão mínima: {0}.": [
      "This app needs an update. Minimum version: {0}.",
      "Esta aplicación necesita una actualización. Versión mínima: {0}."
    ],
    "Falha ao iniciar o aplicativo: {0}": [
      "Could not start the app: {0}",
      "No se pudo iniciar la aplicación: {0}"
    ],
    "Não foi possível consultar os termos da loja: {0}": [
      "Could not load the store's terms: {0}",
      "No se pudieron consultar los términos de la tienda: {0}"
    ],
    "Não foi possível iniciar": ["Could not start", "No se pudo iniciar"],
    "Falha desconhecida.": ["Unknown error.", "Error desconocido."],
    "Tentar novamente": ["Try again", "Intentar de nuevo"],
    "Atualização obrigatória": ["Update required", "Actualización obligatoria"],
    "Atualize o aplicativo para continuar.": [
      "Update the app to continue.",
      "Actualiza la aplicación para continuar."
    ],
    "Verificar novamente": ["Check again", "Verificar de nuevo"],
    "Ajustes do iPhone": ["iPhone Settings", "Ajustes del iPhone"],
    "configurações do Android": ["Android settings", "ajustes de Android"],
    "Assistente virtual": ["Virtual assistant", "Asistente virtual"],
    "A conexão com a loja não foi configurada. Entre em contato com o suporte da loja.":
        [
      "The store connection is not configured. Contact the store's support team.",
      "La conexión con la tienda no está configurada. Contacta con el soporte de la tienda."
    ],
    "Tempo esgotado ao comunicar com a API Mobile. Endereço: {0}{1}": [
      "Mobile API connection timed out. Address: {0}{1}",
      "Se agotó el tiempo de conexión con la API Mobile. Dirección: {0}{1}"
    ],
    "Falha de conexao com a API Mobile: {0}": [
      "Mobile API connection failed: {0}",
      "Error de conexión con la API Mobile: {0}"
    ],
    "A API respondeu HTTP {0}, mas o conteudo nao e JSON valido.": [
      "The API returned HTTP {0}, but the content is not valid JSON.",
      "La API devolvió HTTP {0}, pero el contenido no es JSON válido."
    ],
    "Senha incorreta.": ["Incorrect password.", "Contraseña incorrecta."],
    "Cadastro nao localizado.": ["Account not found.", "Cuenta no encontrada."],
    "Conta bloqueada. Contate o atendimento.": [
      "Account blocked. Contact support.",
      "Cuenta bloqueada. Contacta con atención al cliente."
    ],
    "Conta inativa.": ["Inactive account.", "Cuenta inactiva."],
    "Plataforma nao esta incluida na licenca do modulo Mobile.": [
      "Platform not included in the Mobile license.",
      "Plataforma no incluida en la licencia Mobile."
    ],
    "Plataforma esta desabilitada no configurador do modulo Mobile.": [
      "Platform disabled in the Mobile settings.",
      "Plataforma desactivada en la configuración Mobile."
    ],
    "O modulo Mobile esta desabilitado nesta loja.": [
      "The Mobile module is disabled for this store.",
      "El módulo Mobile está desactivado en esta tienda."
    ],
    "Sua sessao expirou. Entre novamente.": [
      "Your session has expired. Sign in again.",
      "Tu sesión ha caducado. Inicia sesión de nuevo."
    ],
    "Sessao expirada.": ["Session expired.", "Sesión caducada."],
    "A biometria foi desabilitada pelo administrador da loja.": [
      "The store administrator disabled biometric sign-in.",
      "El administrador de la tienda desactivó el acceso biométrico."
    ],
    "Confira os dados informados.": [
      "Check the information you entered.",
      "Revisa los datos introducidos."
    ],
    "Selecione pelo menos um item do carrinho.": [
      "Select at least one cart item.",
      "Selecciona al menos un artículo del carrito."
    ],
    "Há uma opção obrigatória do produto sem preenchimento.": [
      "A required product option is missing.",
      "Falta una opción obligatoria del producto."
    ],
    "Confira os limites informados nas opções do produto.": [
      "Check the product option limits.",
      "Revisa los límites de las opciones del producto."
    ],
    "Um produto selecionado não está mais disponível.": [
      "A selected product is no longer available.",
      "Un producto seleccionado ya no está disponible."
    ],
    "Não foi possível preparar o checkout agora.": [
      "Could not prepare checkout right now.",
      "No se pudo preparar la compra en este momento."
    ],
    "Não foi possível recalcular o frete agora.": [
      "Could not recalculate delivery right now.",
      "No se pudo recalcular el envío en este momento."
    ],
    "Este CPF já está cadastrado.": [
      "This CPF is already registered.",
      "Este CPF ya está registrado."
    ],
    "Este e-mail já está cadastrado.": [
      "This email is already registered.",
      "Este correo electrónico ya está registrado."
    ],
    "Novos cadastros pelo aplicativo estão desabilitados.": [
      "New registrations in the app are disabled.",
      "El registro de nuevas cuentas en la aplicación está desactivado."
    ],
    "Login com Google está desabilitado nesta loja.": [
      "Google sign-in is disabled for this store.",
      "El acceso con Google está desactivado en esta tienda."
    ],
    "Login com Google ainda não foi configurado no módulo Mobile.": [
      "Google sign-in has not been configured in the Mobile module.",
      "El acceso con Google aún no está configurado en el módulo Mobile."
    ],
    "Complete seu cadastro para continuar com o Google.": [
      "Complete your registration to continue with Google.",
      "Completa tu registro para continuar con Google."
    ],
    "Não foi possível validar sua conta Google.": [
      "Could not validate your Google account.",
      "No se pudo validar tu cuenta de Google."
    ],
    "Informe um CPF válido com 11 dígitos.": [
      "Enter a valid 11-digit CPF.",
      "Introduce un CPF válido de 11 dígitos."
    ],
    "Cupom inválido para este pedido.": [
      "Invalid coupon for this order.",
      "Cupón no válido para este pedido."
    ],
    "Erro da API: {0}": ["API error: {0}", "Error de la API: {0}"],
    "Erro HTTP {0} ao comunicar com a API Mobile.": [
      "HTTP error {0} communicating with the Mobile API.",
      "Error HTTP {0} al comunicarse con la API Mobile."
    ],
    "Produto": ["Product", "Producto"],
    "Falar com {0}": ["Talk to {0}", "Hablar con {0}"],
    "Confirmar ação da {0}": [
      "Confirm {0}'s action",
      "Confirmar acción de {0}"
    ],
    "Confirmar · {0}": ["Confirm · {0}", "Confirmar · {0}"],
    "🏷️ Ofertas": ["🏷️ Offers", "🏷️ Ofertas"],
    "Quais são as melhores ofertas de hoje?": [
      "What are today's best offers?",
      "¿Cuáles son las mejores ofertas de hoy?"
    ],
    "🛒 Carrinho": ["🛒 Cart", "🛒 Carrito"],
    "O que tem no meu carrinho?": [
      "What's in my cart?",
      "¿Qué hay en mi carrito?"
    ],
    "📦 Pedido": ["📦 Order", "📦 Pedido"],
    "Como está meu pedido?": ["What's my order status?", "¿Cómo va mi pedido?"],
    "Fale com a {0}...": ["Talk to {0}...", "Habla con {0}..."],
    "Ler código de barras": ["Scan barcode", "Leer código de barras"],
    "Aponte a câmera para o código de barras do produto.": [
      "Point the camera at the product barcode.",
      "Apunta la cámara al código de barras del producto."
    ],
    "Pendentes": ["Pending", "Pendientes"],
    "Em andamento": ["In progress", "En curso"],
    "Finalizados": ["Completed", "Finalizados"],
    "Cancelados": ["Cancelled", "Cancelados"],
    "Todos": ["All", "Todos"],
    "Meus pedidos": ["My orders", "Mis pedidos"],
    "Buscar pedido ou status": [
      "Search order or status",
      "Buscar pedido o estado"
    ],
    "Você ainda não possui pedidos.": [
      "You don't have any orders yet.",
      "Aún no tienes pedidos."
    ],
    "Nenhum pedido neste filtro.": [
      "No orders match this filter.",
      "No hay pedidos con este filtro."
    ],
    "Pedido recebido": ["Order received", "Pedido recibido"],
    "Pedido #{0}": ["Order #{0}", "Pedido #{0}"],
    "O servidor não informou o identificador interno deste pedido. Exibindo os dados disponíveis na listagem.":
        [
      "The server did not provide this order's internal ID. Showing available list information.",
      "El servidor no proporcionó el identificador interno del pedido. Se muestran los datos disponibles en la lista."
    ],
    "Link inválido.": ["Invalid link.", "Enlace no válido."],
    "Não foi possível abrir o link.": [
      "Could not open the link.",
      "No se pudo abrir el enlace."
    ],
    "Este pedido não possui itens para repetir.": [
      "This order has no items to reorder.",
      "Este pedido no tiene artículos para repetir."
    ],
    "Repetir pedido": ["Reorder", "Repetir pedido"],
    "Os produtos serão consultados novamente com preço e disponibilidade atuais. ":
        [
      "Products will be checked again with current prices and availability. ",
      "Los productos se consultarán de nuevo con los precios y la disponibilidad actuales. "
    ],
    "O carrinho atual será substituído pelos itens que ainda puderem ser comprados.":
        [
      "Your current cart will be replaced with items still available for purchase.",
      "Tu carrito actual se reemplazará con los artículos que aún se puedan comprar."
    ],
    "Cancelar": ["Cancel", "Cancelar"],
    "{0}: produto sem identificação.": [
      "{0}: product ID missing.",
      "{0}: producto sin identificación."
    ],
    "{0}: indisponível.": ["{0}: unavailable.", "{0}: no disponible."],
    "{0}: precisa configurar “{1}”.": [
      "{0}: configure “{1}” first.",
      "{0}: debes configurar “{1}”."
    ],
    "{0}: não foi possível consultar o produto atual.": [
      "{0}: could not load current product information.",
      "{0}: no se pudo consultar el producto actual."
    ],
    "Não foi possível repetir": [
      "Could not reorder",
      "No se pudo repetir el pedido"
    ],
    "Nenhum item pôde ser adicionado.": [
      "No items could be added.",
      "No se pudo añadir ningún artículo."
    ],
    "Fechar": ["Close", "Cerrar"],
    "Pedido colocado no carrinho": [
      "Order added to cart",
      "Pedido añadido al carrito"
    ],
    "{0} item(ns) foram adicionados com os dados atuais.": [
      "{0} item(s) added with current information.",
      "Se añadieron {0} artículo(s) con los datos actuales."
    ],
    "{0} item(ns) foram adicionados.\n\nNão adicionados:\n{1}": [
      "{0} item(s) added.\n\nNot added:\n{1}",
      "Se añadieron {0} artículo(s).\n\nNo añadidos:\n{1}"
    ],
    "Pedido": ["Order", "Pedido"],
    "Realizado em {0}": ["Placed on {0}", "Realizado el {0}"],
    "Previsão: {0}": ["Expected: {0}", "Previsión: {0}"],
    "Pago com: {0}": ["Paid with: {0}", "Pagado con: {0}"],
    "Situação financeira: {0}": ["Payment status: {0}", "Estado del pago: {0}"],
    "Informar problema / Abrir disputa": [
      "Report a problem / Open a dispute",
      "Informar de un problema / Abrir disputa"
    ],
    "Detalhes do pedido": ["Order details", "Detalles del pedido"],
    "Modalidade": ["Delivery method", "Modalidad"],
    "Agendamento": ["Schedule", "Programación"],
    "Endereço de entrega": ["Delivery address", "Dirección de entrega"],
    "Cupom": ["Coupon", "Cupón"],
    "Observações": ["Notes", "Observaciones"],
    "Pedido ERP": ["ERP order", "Pedido ERP"],
    "Nota fiscal": ["Invoice", "Factura"],
    "Origem": ["Source", "Origen"],
    "Nenhum detalhe adicional foi retornado pela API.": [
      "The API returned no additional details.",
      "La API no devolvió detalles adicionales."
    ],
    "Itens": ["Items", "Artículos"],
    "A API não retornou os itens deste pedido. Puxe a tela para baixo para tentar novamente.":
        [
      "The API did not return this order's items. Pull down to try again.",
      "La API no devolvió los artículos del pedido. Desliza hacia abajo para intentar de nuevo."
    ],
    "Produtos": ["Products", "Productos"],
    "Frete": ["Delivery fee", "Envío"],
    "Desconto": ["Discount", "Descuento"],
    "Total": ["Total", "Total"],
    "Como foi pago": ["Payment details", "Detalles del pago"],
    "Situação: {0}": ["Status: {0}", "Estado: {0}"],
    "PIX copia e cola": ["PIX copy and paste", "PIX copiar y pegar"],
    "Código PIX copiado.": ["PIX code copied.", "Código PIX copiado."],
    "Copiar PIX": ["Copy PIX", "Copiar PIX"],
    "Código do boleto": ["Boleto code", "Código del boleto"],
    "Código do boleto copiado.": [
      "Boleto code copied.",
      "Código del boleto copiado."
    ],
    "Copiar código": ["Copy code", "Copiar código"],
    "Abrir boleto": ["Open boleto", "Abrir boleto"],
    "Pagamento": ["Payment", "Pago"],
    "Rastreio do pedido": ["Track order", "Seguimiento del pedido"],
    "Código: {0}": ["Code: {0}", "Código: {0}"],
    "Código de rastreio copiado.": [
      "Tracking code copied.",
      "Código de seguimiento copiado."
    ],
    "Atualização": ["Update", "Actualización"],
    "Puxe a tela para baixo para atualizar o andamento. Quando houver código ou link da transportadora, ele aparece aqui.":
        [
      "Pull down to update the status. Carrier codes or links will appear here when available.",
      "Desliza hacia abajo para actualizar el estado. El código o enlace del transportista aparecerá aquí cuando esté disponible."
    ],
    "Acompanhar rastreio": ["Track shipment", "Seguir envío"],
    "Favoritos": ["Favorites", "Favoritos"],
    "Nenhum produto favorito.": [
      "No favorite products.",
      "No hay productos favoritos."
    ],
    "Endereço salvo.": ["Address saved.", "Dirección guardada."],
    "Meus Endereços": ["My Addresses", "Mis Direcciones"],
    "Adicionar endereço": ["Add address", "Añadir dirección"],
    "Nenhum endereço cadastrado.": [
      "No saved addresses.",
      "No hay direcciones guardadas."
    ],
    "Endereço": ["Address", "Dirección"],
    "Editar endereço": ["Edit address", "Editar dirección"],
    "Atualizar": ["Refresh", "Actualizar"],
    "CEP {0}": ["Postal code {0}", "Código postal {0}"],
    "Retirada na loja": ["Store pickup", "Recogida en tienda"],
    "Entrega": ["Delivery", "Entrega"],
    "Pago": ["Paid", "Pagado"],
    "Pendente": ["Pending", "Pendiente"],
    "Recusado": ["Declined", "Rechazado"],
    "Cancelado": ["Cancelled", "Cancelado"],
    "Pagamento na entrega/retirada": [
      "Pay on delivery/pickup",
      "Pago al entregar/recoger"
    ],
    "Sobre o App": ["About the App", "Acerca de la App"],
    "Versão {0} ({1})": ["Version {0} ({1})", "Versión {0} ({1})"],
    "Desenvolvido por {0}": ["Developed by {0}", "Desarrollado por {0}"],
    "Telefone": ["Phone", "Teléfono"],
    "WhatsApp": ["WhatsApp", "WhatsApp"],
    "E-mail": ["Email", "Correo electrónico"],
    "Site": ["Website", "Sitio web"],
    "Termos de Uso e Política de Privacidade": [
      "Terms of Use and Privacy Policy",
      "Términos de Uso y Política de Privacidad"
    ],
    "Preencha {0}.": ["Fill in {0}.", "Completa {0}."],
    "Informe os 8 dígitos do CEP.": [
      "Enter the 8-digit postal code.",
      "Introduce los 8 dígitos del código postal."
    ],
    "Informe uma UF válida.": [
      "Enter a valid Brazilian state code.",
      "Introduce un código de estado brasileño válido."
    ],
    "Novo endereço": ["New address", "Nueva dirección"],
    "Nome do endereço (Casa, Trabalho...)": [
      "Address name (Home, Work...)",
      "Nombre de la dirección (Casa, Trabajo...)"
    ],
    "Rua / Avenida": ["Street / Avenue", "Calle / Avenida"],
    "Número": ["Number", "Número"],
    "Complemento": ["Additional information", "Complemento"],
    "Bairro": ["Neighborhood", "Barrio"],
    "Cidade": ["City", "Ciudad"],
    "Salvar endereço": ["Save address", "Guardar dirección"],
    "Ofertas": ["Offers", "Ofertas"],
    "Categorias": ["Categories", "Categorías"],
    "Loja": ["Store", "Tienda"],
    "Carrinho": ["Cart", "Carrito"],
    "Conta": ["Account", "Cuenta"],
    "Ofertas patrocinadas": ["Sponsored offers", "Ofertas patrocinadas"],
    "Nenhuma oferta ativa neste momento.": [
      "No active offers right now.",
      "No hay ofertas activas en este momento."
    ],
    "Nenhuma oferta patrocinada ativa neste momento.": [
      "No active sponsored offers right now.",
      "No hay ofertas patrocinadas activas en este momento."
    ],
    "Nenhum produto encontrado para esta campanha patrocinada.": [
      "No products found for this sponsored campaign.",
      "No se encontraron productos para esta campaña patrocinada."
    ],
    "Nenhum produto encontrado para esta campanha.": [
      "No products found for this campaign.",
      "No se encontraron productos para esta campaña."
    ],
    "Data promocional": ["Promotional date", "Fecha promocional"],
    "Campanha": ["Campaign", "Campaña"],
    "Filtrar ofertas": ["Filter offers", "Filtrar ofertas"],
    "Todas": ["All", "Todas"],
    "Patrocinadas": ["Sponsored", "Patrocinadas"],
    "Grande": ["Large", "Grande"],
    "Médio": ["Medium", "Mediano"],
    "Pequeno": ["Small", "Pequeño"],
    "A API de vitrine ainda não está instalada no módulo Mobile do servidor.": [
      "The storefront API is not installed in the server's Mobile module yet.",
      "La API del escaparate aún no está instalada en el módulo Mobile del servidor."
    ],
    "Não foi possível carregar mais produtos: {0}": [
      "Could not load more products: {0}",
      "No se pudieron cargar más productos: {0}"
    ],
    "Tema": ["Theme", "Tema"],
    "Tema do aparelho": ["Device theme", "Tema del dispositivo"],
    "Modo claro": ["Light mode", "Modo claro"],
    "Modo escuro": ["Dark mode", "Modo oscuro"],
    "Buscar produtos na loja": [
      "Search store products",
      "Buscar productos en la tienda"
    ],
    "Para você": ["For you", "Para ti"],
    "Carregar mais 20 produtos": [
      "Load 20 more products",
      "Cargar 20 productos más"
    ],
    "Todos os {0} produtos desta listagem foram carregados.": [
      "All {0} products in this list have been loaded.",
      "Se han cargado los {0} productos de esta lista."
    ],
    "Nenhum produto foi encontrado para este código de barras.": [
      "No product found for this barcode.",
      "No se encontró ningún producto con este código de barras."
    ],
    "Buscar": ["Search", "Buscar"],
    "Produto, código, descrição ou código de barras": [
      "Product, code, description or barcode",
      "Producto, código, descripción o código de barras"
    ],
    "Ler código de barras com a câmera": [
      "Scan barcode with camera",
      "Leer código de barras con la cámara"
    ],
    "Nenhum produto encontrado.": [
      "No products found.",
      "No se encontraron productos."
    ],
    "Nao foi possivel validar sua sessao: {0}": [
      "Could not validate your session: {0}",
      "No se pudo validar tu sesión: {0}"
    ],
    "Desmarcar todos": ["Deselect all", "Desmarcar todos"],
    "Selecionar todos": ["Select all", "Seleccionar todos"],
    "Seu carrinho está vazio.": [
      "Your cart is empty.",
      "Tu carrito está vacío."
    ],
    "{0} de {1} item(ns) selecionado(s)": [
      "{0} of {1} item(s) selected",
      "{0} de {1} artículo(s) seleccionado(s)"
    ],
    "{0} {1} no pedido": ["{0} {1} in the order", "{0} {1} en el pedido"],
    "Remover": ["Remove", "Eliminar"],
    "Subtotal selecionado ({0})": [
      "Selected subtotal ({0})",
      "Subtotal seleccionado ({0})"
    ],
    "{0} item(ns) ficaram guardados no carrinho e não entrarão nesta compra.": [
      "{0} item(s) will remain in your cart and are not included in this purchase.",
      "{0} artículo(s) permanecerán en el carrito y no se incluirán en esta compra."
    ],
    "Preço, campanhas, frete e pedido mínimo serão recalculados pelo servidor somente com os itens selecionados.":
        [
      "The server will recalculate prices, campaigns, delivery fees and minimum order using only selected items.",
      "El servidor recalculará los precios, campañas, envío y pedido mínimo solo con los artículos seleccionados."
    ],
    "Selecione ao menos um item": [
      "Select at least one item",
      "Selecciona al menos un artículo"
    ],
    "Continuar com {0} item(ns) · {1}": [
      "Continue with {0} item(s) · {1}",
      "Continuar con {0} artículo(s) · {1}"
    ],
    "Foto de perfil atualizada.": [
      "Profile photo updated.",
      "Foto de perfil actualizada."
    ],
    "Foto de perfil": ["Profile photo", "Foto de perfil"],
    "Enviar / trocar foto": ["Upload / change photo", "Subir / cambiar foto"],
    "Abrir / baixar foto": ["Open / download photo", "Abrir / descargar foto"],
    "Remover foto": ["Remove photo", "Eliminar foto"],
    "Minha conta": ["My account", "Mi cuenta"],
    "Cliente": ["Customer", "Cliente"],
    "Entre na sua conta": [
      "Sign in to your account",
      "Inicia sesión en tu cuenta"
    ],
    "Acompanhe seus pedidos e endereços.": [
      "Track your orders and addresses.",
      "Consulta tus pedidos y direcciones."
    ],
    "Login por e-mail ou CPF.": [
      "Sign in with email or CPF.",
      "Accede con correo electrónico o CPF."
    ],
    "Meus Pedidos": ["My Orders", "Mis Pedidos"],
    "Fale com a Loja": ["Contact the Store", "Contactar con la Tienda"],
    "Configurações Locais e Segurança": [
      "Local Settings and Security",
      "Configuración Local y Seguridad"
    ],
    "Sair": ["Sign out", "Cerrar sesión"],
    "Entrar": ["Sign in", "Iniciar sesión"],
    "Remover dos favoritos": ["Remove from favorites", "Eliminar de favoritos"],
    "Favoritar": ["Add to favorites", "Añadir a favoritos"],
    "Adicionar ao carrinho": ["Add to cart", "Añadir al carrito"],
    "Preço cheio: {0}": ["Regular price: {0}", "Precio habitual: {0}"],
    "Tamanho dos produtos": ["Product size", "Tamaño de productos"],
    "Ordenar produtos": ["Sort products", "Ordenar productos"],
    "Ordenar": ["Sort", "Ordenar"],
    "PATROCINADO POR": ["SPONSORED BY", "PATROCINADO POR"],
    "CONTEÚDO\nPATROCINADO": ["SPONSORED\nCONTENT", "CONTENIDO\nPATROCINADO"],
    "Ver ofertas →": ["View offers →", "Ver ofertas →"],
    "Trocar campanha": ["Change campaign", "Cambiar campaña"],
    "Adicionar": ["Add", "Añadir"],
    "Patrocinado": ["Sponsored", "Patrocinado"],
    "Loja Mobile": ["Mobile Store", "Tienda Mobile"],
    "por {0}": ["per {0}", "por {0}"],
    "Não foi possível abrir o contato.": [
      "Could not open contact link.",
      "No se pudo abrir el contacto."
    ],
    "Fale com a loja": ["Contact the store", "Contactar con la tienda"],
    "Olá! Gostaria de atendimento.": [
      "Hello! I'd like some assistance.",
      "¡Hola! Me gustaría recibir atención."
    ],
    "Olá! Preciso de atendimento sobre o pedido #{0}{1}": [
      "Hello! I need assistance with order #{0}{1}",
      "¡Hola! Necesito atención para el pedido #{0}{1}"
    ],
    "CNPJ: {0}": ["CNPJ: {0}", "CNPJ: {0}"],
    "Atendimento: {0}": ["Support hours: {0}", "Horario de atención: {0}"],
    "Falar com a loja no WhatsApp": [
      "Contact the store on WhatsApp",
      "Hablar con la tienda por WhatsApp"
    ],
    "Página de contato da loja": [
      "Store contact page",
      "Página de contacto de la tienda"
    ],
    "A loja ainda não cadastrou os contatos de atendimento.": [
      "The store has not registered its support contacts yet.",
      "La tienda aún no ha registrado sus contactos de atención."
    ],
    "Leia os documentos atualizados e confirme o aceite.": [
      "Read the latest documents and confirm your acceptance.",
      "Lee los documentos actualizados y confirma tu aceptación."
    ],
    "Política de Privacidade": ["Privacy Policy", "Política de Privacidad"],
    "Termos e privacidade": ["Terms and privacy", "Términos y privacidad"],
    "A loja ainda não publicou os documentos legais no cadastro. Consulte o atendimento da loja.":
        [
      "The store has not published its legal documents yet. Contact the store's support team.",
      "La tienda aún no ha publicado sus documentos legales. Contacta con atención al cliente."
    ],
    "Consultar Termos de Uso": [
      "View Terms of Use",
      "Consultar Términos de Uso"
    ],
    "Versão {0}": ["Version {0}", "Versión {0}"],
    "Abrir documento no site": [
      "Open document on website",
      "Abrir documento en el sitio web"
    ],
    "Esta versão já foi aceita.": [
      "This version has already been accepted.",
      "Esta versión ya ha sido aceptada."
    ],
    "Li e aceito os termos de uso e estou ciente da política de privacidade.": [
      "I have read and accept the terms of use and acknowledge the privacy policy.",
      "He leído y acepto los términos de uso y conozco la política de privacidad."
    ],
    "Confirmar e continuar": ["Confirm and continue", "Confirmar y continuar"],
    "Continuar": ["Continue", "Continuar"],
    "Continuar cadastro": ["Continue registration", "Continuar registro"],
    "Acesso aos meus dados": ["Access to my data", "Acceso a mis datos"],
    "Correção de dados": ["Correct my data", "Corrección de datos"],
    "Exclusão da conta e dos dados": [
      "Delete account and data",
      "Eliminar cuenta y datos"
    ],
    "Revogação de consentimento": [
      "Withdraw consent",
      "Revocar consentimiento"
    ],
    "Outra solicitação": ["Other request", "Otra solicitud"],
    "Descreva sua solicitação.": [
      "Describe your request.",
      "Describe tu solicitud."
    ],
    "Privacidade e meus dados": [
      "Privacy and my data",
      "Privacidad y mis datos"
    ],
    "Consulte a política de privacidade ou envie à loja uma solicitação sobre seus dados pessoais.":
        [
      "View the privacy policy or send the store a request about your personal data.",
      "Consulta la política de privacidad o envía a la tienda una solicitud sobre tus datos personales."
    ],
    "Consultar termos e política de privacidade": [
      "View terms and privacy policy",
      "Consultar términos y política de privacidad"
    ],
    "Tipo de solicitação": ["Request type", "Tipo de solicitud"],
    "Sua solicitação": ["Your request", "Tu solicitud"],
    "A loja analisará a exclusão da conta e dos dados. Registros que precisem ser mantidos serão informados na resposta.":
        [
      "The store will review account and data deletion. Any records that must be retained will be explained in the response.",
      "La tienda revisará la eliminación de la cuenta y los datos. Los registros que deban conservarse se indicarán en la respuesta."
    ],
    "Informe qual autorização deseja revogar.": [
      "Specify which permission you want to revoke.",
      "Indica qué autorización deseas revocar."
    ],
    "Enviando...": ["Sending...", "Enviando..."],
    "Enviar solicitação à loja": [
      "Send request to the store",
      "Enviar solicitud a la tienda"
    ],
    "Minhas solicitações": ["My requests", "Mis solicitudes"],
    "Status: {0}": ["Status: {0}", "Estado: {0}"],
    "Resposta da loja: {0}": [
      "Store response: {0}",
      "Respuesta de la tienda: {0}"
    ],
    "Desisti da compra": ["Changed my mind", "Desistí de la compra"],
    "Pedido incorreto": ["Incorrect order", "Pedido incorrecto"],
    "Produto faltando": ["Missing product", "Falta un producto"],
    "Produto com problema": [
      "Problem with product",
      "Problema con el producto"
    ],
    "Atraso na entrega": ["Late delivery", "Retraso en la entrega"],
    "Não reconheço o pedido": [
      "I don't recognize this order",
      "No reconozco el pedido"
    ],
    "Outro motivo": ["Other reason", "Otro motivo"],
    "Selecione o motivo e descreva o problema.": [
      "Select a reason and describe the problem.",
      "Selecciona el motivo y describe el problema."
    ],
    "Solicitação #{0} registrada": [
      "Request #{0} registered",
      "Solicitud #{0} registrada"
    ],
    "Você pode acompanhar a resposta da loja nesta tela.": [
      "You can follow the store's response on this screen.",
      "Puedes consultar la respuesta de la tienda en esta pantalla."
    ],
    "Deseja também falar com a loja pelo WhatsApp?": [
      "Would you also like to contact the store on WhatsApp?",
      "¿Quieres también hablar con la tienda por WhatsApp?"
    ],
    "Acompanhar no app": ["Track in the app", "Consultar en la aplicación"],
    "Falar no WhatsApp": ["Chat on WhatsApp", "Hablar por WhatsApp"],
    "Olá! Abri a solicitação #{0} sobre o pedido #{1} e gostaria de atendimento.":
        [
      "Hello! I opened request #{0} for order #{1} and would like some assistance.",
      "¡Hola! Abrí la solicitud #{0} para el pedido #{1} y me gustaría recibir atención."
    ],
    "Atendimento do pedido": ["Order support", "Atención del pedido"],
    "Atendimento do pedido #{0}": [
      "Support for order #{0}",
      "Atención del pedido #{0}"
    ],
    "O formulário de atendimento ainda não está disponível no app desta loja.":
        [
      "The support form is not available in this store's app yet.",
      "El formulario de atención aún no está disponible en la aplicación de esta tienda."
    ],
    "Abrir atendimento no site": [
      "Open support on website",
      "Abrir atención en el sitio web"
    ],
    "Informe o problema à loja. Sua solicitação ficará vinculada ao pedido e ao atendimento do site.":
        [
      "Report the problem to the store. Your request will be linked to the order and website support.",
      "Informa del problema a la tienda. Tu solicitud quedará vinculada al pedido y a la atención del sitio web."
    ],
    "Tipo": ["Type", "Tipo"],
    "Motivo": ["Reason", "Motivo"],
    "Conte para a loja o que aconteceu": [
      "Tell the store what happened",
      "Cuenta a la tienda qué ocurrió"
    ],
    "Enviar solicitação": ["Send request", "Enviar solicitud"],
    "Solicitação #{0} — {1}": ["Request #{0} — {1}", "Solicitud #{0} — {1}"],
    "Motivo: {0}": ["Reason: {0}", "Motivo: {0}"],
    "Resposta da loja": ["Store response", "Respuesta de la tienda"],
    "Histórico": ["History", "Historial"],
    "Oferta": ["Offer", "Oferta"],
    "Categoria": ["Category", "Categoría"],
    "Promoção": ["Promotion", "Promoción"],
    "Opção": ["Option", "Opción"],
    "Oferta aplicada.": ["Offer applied.", "Oferta aplicada."],
    "Preço promocional ativado.": [
      "Promotional price activated.",
      "Precio promocional activado."
    ],
    "Faltam {0} {1} para ativar a promoção.": [
      "{0} {1} more to activate the promotion.",
      "Faltan {0} {1} para activar la promoción."
    ],
    "Leve {0} e pague {1} aplicado.": [
      "Buy {0}, pay for {1} applied.",
      "Compra {0} y paga {1} aplicado."
    ],
    "Adicione mais {0} {1} para ativar a promoção.": [
      "Add {0} {1} more to activate the promotion.",
      "Añade {0} {1} más para activar la promoción."
    ],
    "A-Z": ["A-Z", "A-Z"],
    "Z-A": ["Z-A", "Z-A"],
    "Preço: menor → maior": ["Price: low → high", "Precio: menor → mayor"],
    "Preço: maior → menor": ["Price: high → low", "Precio: mayor → menor"],
    "Departamento: A-Z": ["Department: A-Z", "Departamento: A-Z"],
    "Departamento: Z-A": ["Department: Z-A", "Departamento: Z-A"],
    "Padrão: ofertas e favoritos": [
      "Default: offers and favorites",
      "Predeterminado: ofertas y favoritos"
    ],
    "Campanhas em destaque": ["Featured campaigns", "Campañas destacadas"],
    "Cadastre uma digital ou reconhecimento facial em {0}.": [
      "Set up a fingerprint or face recognition in {0}.",
      "Configura una huella o reconocimiento facial en {0}."
    ],
    "Ative “Manter conectado” no próximo login para usar a biometria.": [
      "Enable “Keep me signed in” on your next login to use biometrics.",
      "Activa “Mantener la sesión” en tu próximo acceso para usar biometría."
    ],
    "Confirme sua biometria para habilitar o acesso ao aplicativo": [
      "Confirm your biometrics to enable app access",
      "Confirma tu biometría para habilitar el acceso a la aplicación"
    ],
    "Acesso por biometria ativado.": [
      "Biometric sign-in enabled.",
      "Acceso biométrico activado."
    ],
    "Acesso por biometria desativado.": [
      "Biometric sign-in disabled.",
      "Acceso biométrico desactivado."
    ],
    "Não foi possível alterar a biometria. Tente novamente.": [
      "Could not change biometric settings. Try again.",
      "No se pudo cambiar la biometría. Intenta de nuevo."
    ],
    "Não foi possível alterar as notificações. Tente novamente.": [
      "Could not change notification settings. Try again.",
      "No se pudieron cambiar las notificaciones. Intenta de nuevo."
    ],
    "Entrar com biometria": [
      "Sign in with biometrics",
      "Acceder con biometría"
    ],
    "Biometria desativada pela loja.": [
      "Biometrics disabled by the store.",
      "Biometría desactivada por la tienda."
    ],
    "Use sua digital ou reconhecimento facial neste aparelho.": [
      "Use your fingerprint or face recognition on this device.",
      "Usa tu huella o reconocimiento facial en este dispositivo."
    ],
    "Cadastre uma biometria em {0}.": [
      "Set up biometrics in {0}.",
      "Configura la biometría en {0}."
    ],
    "Notificações": ["Notifications", "Notificaciones"],
    "Notificações desativadas pela loja.": [
      "Notifications disabled by the store.",
      "Notificaciones desactivadas por la tienda."
    ],
    "Entre na sua conta para continuar a compra.": [
      "Sign in to continue your purchase.",
      "Inicia sesión para continuar la compra."
    ],
    "Entre na sua conta para continuar.": [
      "Sign in to continue.",
      "Inicia sesión para continuar."
    ],
    "Digite o código do cupom.": [
      "Enter the coupon code.",
      "Introduce el código del cupón."
    ],
    "Cupom aplicado.": ["Coupon applied.", "Cupón aplicado."],
    "Public Key Pagar.me não configurada.": [
      "Pagar.me public key not configured.",
      "Clave pública de Pagar.me no configurada."
    ],
    "Confira os dados do cartão.": [
      "Check your card details.",
      "Revisa los datos de la tarjeta."
    ],
    "Validade do cartão inválida.": [
      "Invalid card expiration date.",
      "Fecha de caducidad de la tarjeta no válida."
    ],
    "Não foi possível validar o cartão no Pagar.me.": [
      "Could not validate the card with Pagar.me.",
      "No se pudo validar la tarjeta en Pagar.me."
    ],
    "Google Pay não está habilitado nesta compilação do aplicativo.": [
      "Google Pay is not enabled in this app build.",
      "Google Pay no está habilitado en esta compilación de la aplicación."
    ],
    "Google Pay ainda não está configurado para este HUB.": [
      "Google Pay has not been configured for this HUB yet.",
      "Google Pay aún no está configurado para este HUB."
    ],
    "Google Pay não está disponível neste aparelho/conta.": [
      "Google Pay is not available on this device/account.",
      "Google Pay no está disponible en este dispositivo o cuenta."
    ],
    "Informe para quanto precisa de troco.": [
      "Enter the amount you need change for.",
      "Indica para qué importe necesitas cambio."
    ],
    "O valor para troco não pode ser menor que {0}.": [
      "The amount for change cannot be less than {0}.",
      "El importe para el cambio no puede ser inferior a {0}."
    ],
    "Cartão online ainda não está disponível para este HUB.": [
      "Online card payment is not available for this HUB yet.",
      "El pago con tarjeta en línea aún no está disponible para este HUB."
    ],
    "Google Pay não está disponível.": [
      "Google Pay is not available.",
      "Google Pay no está disponible."
    ],
    "Não foi possível concluir o pedido: {0}": [
      "Could not complete the order: {0}",
      "No se pudo completar el pedido: {0}"
    ],
    "Escolha a data da retirada": [
      "Choose a pickup date",
      "Elige la fecha de recogida"
    ],
    "Escolha a data da entrega": [
      "Choose a delivery date",
      "Elige la fecha de entrega"
    ],
    "Onde deseja receber?": [
      "Where should we deliver?",
      "¿Dónde quieres recibir el pedido?"
    ],
    "Os endereços fora da área atendida ficam desativados.": [
      "Addresses outside the delivery area are disabled.",
      "Las direcciones fuera del área de entrega están desactivadas."
    ],
    "Disponível": ["Available", "Disponible"],
    "Indisponível": ["Unavailable", "No disponible"],
    "Finalizar compra": ["Checkout", "Finalizar compra"],
    "Como deseja receber?": [
      "How would you like to receive your order?",
      "¿Cómo quieres recibir el pedido?"
    ],
    "Retirada": ["Pickup", "Recogida"],
    "Nenhum endereço cadastrado. Cadastre um endereço na sua conta.": [
      "No saved addresses. Add an address to your account.",
      "No hay direcciones guardadas. Añade una dirección a tu cuenta."
    ],
    "Escolha um endereço": ["Choose an address", "Elige una dirección"],
    "Data da retirada": ["Pickup date", "Fecha de recogida"],
    "Data da entrega": ["Delivery date", "Fecha de entrega"],
    "Escolher data": ["Choose date", "Elegir fecha"],
    "Toque para abrir o calendário": [
      "Tap to open calendar",
      "Toca para abrir el calendario"
    ],
    "Cupom de desconto": ["Discount coupon", "Cupón de descuento"],
    "Digite o código": ["Enter code", "Introduce el código"],
    "Aplicar": ["Apply", "Aplicar"],
    "Economia: {0}": ["Savings: {0}", "Ahorro: {0}"],
    "Resumo do pedido": ["Order summary", "Resumen del pedido"],
    "Produtos ({0})": ["Products ({0})", "Productos ({0})"],
    "Grátis": ["Free", "Gratis"],
    "Total do pedido": ["Order total", "Total del pedido"],
    "Endereço fora da área de entrega.": [
      "Address outside the delivery area.",
      "Dirección fuera del área de entrega."
    ],
    "Faltam {0} para o pedido mínimo.": [
      "{0} more to reach the minimum order.",
      "Faltan {0} para el pedido mínimo."
    ],
    "Nenhum meio de pagamento disponível para este pedido.": [
      "No payment methods available for this order.",
      "No hay medios de pago disponibles para este pedido."
    ],
    "Google Pay não foi habilitado nesta compilação.": [
      "Google Pay was not enabled in this build.",
      "Google Pay no está habilitado en esta compilación."
    ],
    "Online · {0}": ["Online · {0}", "En línea · {0}"],
    "Condição / prazo": ["Payment terms", "Condición / plazo"],
    "Precisa de troco?": ["Need change?", "¿Necesitas cambio?"],
    "Informe o valor que será entregue ao motorista.": [
      "Enter the amount you will give the driver.",
      "Indica el importe que entregarás al repartidor."
    ],
    "Troco para quanto?": ["Change for how much?", "¿Cambio para qué importe?"],
    "Ex.: 100,00": ["E.g.: 100,00", "Ej.: 100,00"],
    "Observações do pedido": ["Order notes", "Observaciones del pedido"],
    "Ex.: chamar no interfone, entregar na portaria, não substituir itens...": [
      "E.g.: ring the intercom, leave at reception, no substitutions...",
      "Ej.: llamar al interfono, entregar en recepción, no sustituir artículos..."
    ],
    "Confirmando pedido...": ["Confirming order...", "Confirmando pedido..."],
    "Confirmar pedido · {0}": ["Confirm order · {0}", "Confirmar pedido · {0}"],
    "Confirmação do pedido indisponível": [
      "Order confirmation unavailable",
      "Confirmación del pedido no disponible"
    ],
    "Pedido realizado": ["Order placed", "Pedido realizado"],
    "Pedido #{0} recebido!": ["Order #{0} received!", "¡Pedido #{0} recibido!"],
    "Total {0}": ["Total {0}", "Total {0}"],
    "O pedido foi criado, mas o pagamento precisa de atenção: {0}": [
      "The order was created, but the payment needs attention: {0}",
      "El pedido se creó, pero el pago necesita atención: {0}"
    ],
    "Boleto": ["Boleto", "Boleto"],
    "Continuar na loja": ["Continue shopping", "Continuar en la tienda"],
    "Você pode acompanhar este pedido em Conta > Meus pedidos.": [
      "You can track this order in Account > My orders.",
      "Puedes consultar este pedido en Cuenta > Mis pedidos."
    ],
    "Número do cartão": ["Card number", "Número de tarjeta"],
    "Nome impresso no cartão": ["Name on card", "Nombre en la tarjeta"],
    "Validade": ["Expiration date", "Caducidad"],
    "Parcelas": ["Installments", "Cuotas"],
    "1x no cartão": ["Single card payment", "Un pago con tarjeta"],
    "Os dados do cartão são tokenizados diretamente no Pagar.me; o número e o CVV não são enviados ao ecommerce.":
        [
      "Card details are tokenized directly by Pagar.me; the card number and CVV are not sent to the store.",
      "Los datos de la tarjeta se tokenizan directamente en Pagar.me; el número y el CVV no se envían a la tienda."
    ],
    "ESPÉCIE": ["CASH", "EFECTIVO"],
    "Seg": ["Mon", "Lun"],
    "Ter": ["Tue", "Mar"],
    "Qua": ["Wed", "Mié"],
    "Qui": ["Thu", "Jue"],
    "Sex": ["Fri", "Vie"],
    "Sáb": ["Sat", "Sáb"],
    "Dom": ["Sun", "Dom"],
    "Preencha “{0}”.": ["Fill in “{0}”.", "Completa “{0}”."],
    "Selecione “{0}”.": ["Select “{0}”.", "Selecciona “{0}”."],
    "Valor inválido em “{0}”.": [
      "Invalid value in “{0}”.",
      "Valor no válido en “{0}”."
    ],
    "“{0}” deve ser no mínimo {1} {2}.": [
      "“{0}” must be at least {1} {2}.",
      "“{0}” debe ser como mínimo {1} {2}."
    ],
    "“{0}” deve ser no máximo {1} {2}.": [
      "“{0}” must be at most {1} {2}.",
      "“{0}” debe ser como máximo {1} {2}."
    ],
    "Obs Cliente: {0}": ["Customer note: {0}", "Observación del cliente: {0}"],
    "Produto adicionado ao carrinho.": [
      "Product added to cart.",
      "Producto añadido al carrito."
    ],
    "Antes de continuar": ["Before continuing", "Antes de continuar"],
    "Deseja adicionar “{0}” ao carrinho antes de abrir “{1}”?": [
      "Add “{0}” to the cart before opening “{1}”?",
      "¿Quieres añadir “{0}” al carrito antes de abrir “{1}”?"
    ],
    "Não, continuar": ["No, continue", "No, continuar"],
    "Adicionar e continuar": ["Add and continue", "Añadir y continuar"],
    "Cód. {0}": ["Code {0}", "Cód. {0}"],
    "Unidade: {0}": ["Unit: {0}", "Unidad: {0}"],
    "Personalize o item": ["Customize item", "Personaliza el artículo"],
    "Escolha corte, preparo, porção/embalagem e demais opções disponíveis para este produto.":
        [
      "Choose cut, preparation, portion/packaging and other options available for this product.",
      "Elige corte, preparación, porción/envase y demás opciones disponibles para este producto."
    ],
    "Observações especiais": ["Special notes", "Observaciones especiales"],
    "Ex.: preferência de corte, gordura...": [
      "E.g.: cut preference, fat...",
      "Ej.: preferencia de corte, grasa..."
    ],
    "Informações do produto": [
      "Product information",
      "Información del producto"
    ],
    "Ficha técnica e informações": [
      "Specifications and information",
      "Ficha técnica e información"
    ],
    "Código de barras: {0}": ["Barcode: {0}", "Código de barras: {0}"],
    "Adicionar ao carrinho · {0}": [
      "Add to cart · {0}",
      "Añadir al carrito · {0}"
    ],
    "Selecione...": ["Select...", "Selecciona..."],
    "mín. {0}": ["min. {0}", "mín. {0}"],
    "máx. {0}": ["max. {0}", "máx. {0}"],
    "passo {0}": ["step {0}", "paso {0}"],
    "Link de vídeo inválido.": [
      "Invalid video link.",
      "Enlace de vídeo no válido."
    ],
    "Não foi possível abrir o vídeo.": [
      "Could not open the video.",
      "No se pudo abrir el vídeo."
    ],
    "Vídeo do produto · toque para reproduzir": [
      "Product video · tap to play",
      "Vídeo del producto · toca para reproducir"
    ],
    "Você também pode gostar": ["You may also like", "También te puede gustar"],
    "Na promoção sai por {0} {1}": [
      "Promotional price {0} {1}",
      "En promoción cuesta {0} {1}"
    ],
    "A partir de {0} {1}: {2} {3}": [
      "From {0} {1}: {2} {3}",
      "A partir de {0} {1}: {2} {3}"
    ],
    "Leve {0} e pague {1}": ["Buy {0}, pay for {1}", "Compra {0} y paga {1}"],
    "Quantidade": ["Quantity", "Cantidad"],
    "Total estimado": ["Estimated total", "Total estimado"],
    "Pedido será gerado em {0}: {1} {2}": [
      "Order will use {0}: {1} {2}",
      "El pedido se generará en {0}: {1} {2}"
    ],
    "Quantidade aceita até {0} casas decimais. Mínimo {1} {2}.{3}": [
      "Quantity allows up to {0} decimal places. Minimum {1} {2}.{3}",
      "La cantidad admite hasta {0} decimales. Mínimo {1} {2}.{3}"
    ],
    "a unidade": ["per unit", "por unidad"],
    "Identificador do pedido não informado.": [
      "Order ID not provided.",
      "Identificador del pedido no informado."
    ],
    "O servidor não retornou os detalhes do pedido.": [
      "The server did not return order details.",
      "El servidor no devolvió los detalles del pedido."
    ],
    "Produto não localizado.": [
      "Product not found.",
      "Producto no encontrado."
    ],
    "Informe nome, CPF e e-mail corretamente.": [
      "Enter a valid name, CPF and email.",
      "Introduce correctamente nombre, CPF y correo electrónico."
    ],
    "Preencha o endereço principal completo.": [
      "Fill in your complete primary address.",
      "Completa la dirección principal."
    ],
    "A senha precisa ter pelo menos 6 caracteres.": [
      "The password must have at least 6 characters.",
      "La contraseña debe tener al menos 6 caracteres."
    ],
    "As senhas não conferem.": [
      "Passwords do not match.",
      "Las contraseñas no coinciden."
    ],
    "É necessário aceitar os termos e a política de privacidade.": [
      "You must accept the terms and privacy policy.",
      "Debes aceptar los términos y la política de privacidad."
    ],
    "Completar cadastro Google": [
      "Complete Google registration",
      "Completar registro de Google"
    ],
    "Criar conta": ["Create account", "Crear cuenta"],
    "Sua conta Google foi validada. Complete os dados necessários para entrega e faturamento.":
        [
      "Your Google account was verified. Complete the information required for delivery and billing.",
      "Tu cuenta de Google fue validada. Completa los datos necesarios para entrega y facturación."
    ],
    "Nome completo": ["Full name", "Nombre completo"],
    "Celular": ["Mobile phone", "Celular"],
    "Endereço principal": ["Primary address", "Dirección principal"],
    "Complemento (opcional)": [
      "Additional information (optional)",
      "Complemento (opcional)"
    ],
    "Senha": ["Password", "Contraseña"],
    "Confirmar senha": ["Confirm password", "Confirmar contraseña"],
    "Ler e aceitar os termos de uso e a política de privacidade.": [
      "Read and accept the terms of use and privacy policy.",
      "Leer y aceptar los términos de uso y la política de privacidad."
    ],
    "CONCLUIR CADASTRO": ["COMPLETE REGISTRATION", "COMPLETAR REGISTRO"],
    "CRIAR MINHA CONTA": ["CREATE MY ACCOUNT", "CREAR MI CUENTA"],
    "Informe o e-mail/CPF e a senha.": [
      "Enter your email/CPF and password.",
      "Introduce correo electrónico/CPF y contraseña."
    ],
    "Ativar login por biometria?": [
      "Enable biometric sign-in?",
      "¿Activar el acceso biométrico?"
    ],
    "A senha nao sera armazenada. A biometria deste aparelho apenas ": [
      "Your password will not be stored. This device's biometrics only ",
      "La contraseña no se guardará. La biometría de este dispositivo solo "
    ],
    "libera a sessao segura salva no dispositivo.": [
      "unlocks the secure session saved on the device.",
      "desbloquea la sesión segura guardada en el dispositivo."
    ],
    "Agora nao": ["Not now", "Ahora no"],
    "Ativar": ["Enable", "Activar"],
    "Confirme sua biometria para ativar o login rápido": [
      "Confirm your biometrics to enable quick sign-in",
      "Confirma tu biometría para activar el acceso rápido"
    ],
    "Nao foi possivel entrar. {0}": [
      "Could not sign in. {0}",
      "No se pudo iniciar sesión. {0}"
    ],
    "O Google não retornou um token de identidade.": [
      "Google did not return an identity token.",
      "Google no devolvió un token de identidad."
    ],
    "Não foi possível entrar com o Google. {0}": [
      "Could not sign in with Google. {0}",
      "No se pudo iniciar sesión con Google. {0}"
    ],
    "Recuperação de senha não está disponível nesta loja.": [
      "Password recovery is unavailable for this store.",
      "La recuperación de contraseña no está disponible en esta tienda."
    ],
    "Endereço de recuperação de senha inválido.": [
      "Invalid password recovery address.",
      "Dirección de recuperación de contraseña no válida."
    ],
    "Não foi possível abrir a recuperação de senha.": [
      "Could not open password recovery.",
      "No se pudo abrir la recuperación de contraseña."
    ],
    "Biometria não confirmada.": [
      "Biometrics not confirmed.",
      "Biometría no confirmada."
    ],
    "Sua sessão expirou. Entre com sua senha novamente.": [
      "Your session has expired. Sign in with your password again.",
      "Tu sesión ha caducado. Accede de nuevo con tu contraseña."
    ],
    "Confirme sua identidade para entrar": [
      "Confirm your identity to sign in",
      "Confirma tu identidad para acceder"
    ],
    "E-mail ou CPF/CNPJ": [
      "Email or CPF/CNPJ",
      "Correo electrónico o CPF/CNPJ"
    ],
    "Esqueci minha senha": ["Forgot my password", "Olvidé mi contraseña"],
    "Manter conectado": ["Keep me signed in", "Mantener la sesión"],
    "Continuar com Google": ["Continue with Google", "Continuar con Google"],
    "Criar uma conta": ["Create an account", "Crear una cuenta"],
    "Os produtos serão consultados novamente com preço e disponibilidade atuais. O carrinho atual será substituído pelos itens que ainda puderem ser comprados.":
        [
      "Products will be checked again with current prices and availability. Your current cart will be replaced with items still available for purchase.",
      "Los productos se consultarán de nuevo con los precios y la disponibilidad actuales. Tu carrito actual se reemplazará con los artículos que aún se puedan comprar."
    ],
    "A senha nao sera armazenada. A biometria deste aparelho apenas libera a sessao segura salva no dispositivo.":
        [
      "Your password will not be stored. This device's biometrics only unlocks the secure session saved on the device.",
      "La contraseña no se guardará. La biometría de este dispositivo solo desbloquea la sesión segura guardada en el dispositivo."
    ],
    "Idioma": ["Language", "Idioma"],
    "Português": ["Portuguese", "Portugués"],
    "Inglês": ["English", "Inglés"],
    "Espanhol": ["Spanish", "Español"],
    "O idioma foi salvo neste aparelho.": [
      "Language saved on this device.",
      "Idioma guardado en este dispositivo."
    ],
    "Não foi possível salvar o idioma. Tente novamente.": [
      "Could not save the language. Try again.",
      "No se pudo guardar el idioma. Intenta de nuevo."
    ],
    "Permissão do aparelho": ["Device permission", "Permiso del dispositivo"],
    "Permitidas": ["Allowed", "Permitidas"],
    "Permissão não solicitada": [
      "Permission not requested",
      "Permiso no solicitado"
    ],
    "Bloqueadas no aparelho": [
      "Blocked on the device",
      "Bloqueadas en el dispositivo"
    ],
    "Permissão negada": ["Permission denied", "Permiso denegado"],
    "Permissão indisponível": [
      "Permission unavailable",
      "Permiso no disponible"
    ],
    "Verificando permissão...": [
      "Checking permission...",
      "Verificando permiso..."
    ],
    "Permita as notificações nas configurações do aparelho.": [
      "Allow notifications in your device settings.",
      "Permite las notificaciones en los ajustes del dispositivo."
    ],
    "Abrir configurações do aparelho": [
      "Open device settings",
      "Abrir ajustes del dispositivo"
    ],
    "Não foi possível abrir as configurações do aparelho.": [
      "Could not open device settings.",
      "No se pudieron abrir los ajustes del dispositivo."
    ],
    "Não foi possível verificar a permissão de notificações.": [
      "Could not check notification permission.",
      "No se pudo verificar el permiso de notificaciones."
    ],
    "Notificações permitidas neste aparelho.": [
      "Notifications allowed on this device.",
      "Notificaciones permitidas en este dispositivo."
    ],
    "Notificações desativadas neste aparelho.": [
      "Notifications disabled on this device.",
      "Notificaciones desactivadas en este dispositivo."
    ],
    "Ative para permitir avisos da loja sobre seus pedidos.": [
      "Enable to allow store notifications about your orders.",
      "Activa para permitir avisos de la tienda sobre tus pedidos."
    ],
    "Redes sociais": ["Social media", "Redes sociales"],
    "Atendimento da loja": ["Store support", "Atención de la tienda"],
    ", solicitação #{0}.": [", request #{0}.", ", solicitud #{0}."],
    " Digite os números; a vírgula é colocada automaticamente.": [
      " Enter digits; the decimal separator is inserted automatically.",
      " Introduce los números; el separador decimal se coloca automáticamente."
    ],
    " Digite uma quantidade inteira.": [
      " Enter a whole quantity.",
      " Introduce una cantidad entera."
    ],
    "UF": ["State", "Estado"],
    "CEP": ["Postal code", "Código postal"],
    "OFERTA": ["OFFER", "OFERTA"],
    "PATROCINADO": ["SPONSORED", "PATROCINADO"],
    "CANCELAMENTO": ["CANCELLATION", "CANCELACIÓN"],
    "RECLAMACAO": ["COMPLAINT", "RECLAMACIÓN"],
    "ENTREGA": ["DELIVERY", "ENTREGA"],
    "ABERTA": ["OPEN", "ABIERTA"],
    "EM_ANALISE": ["UNDER REVIEW", "EN REVISIÓN"],
    "APROVADA": ["APPROVED", "APROBADA"],
    "NEGADA": ["DENIED", "DENEGADA"],
    "CONCLUIDA": ["COMPLETED", "CONCLUIDA"],
    "CANCELADA": ["CANCELLED", "CANCELADA"]
  };
  static final _templates = messages.entries
      .where((e) => RegExp(r'\{\d+\}').hasMatch(e.key))
      .map((e) => _MessageTemplate(e.key, e.value))
      .toList()
    ..sort((a, b) => b.specificity.compareTo(a.specificity));
  static final Map<String, String> _cache = {};

  static String translate(String text, String language, [int depth = 0]) {
    if (language == 'pt' || !{'en', 'es'}.contains(language)) return text;
    final index = language == 'en' ? 0 : 1;
    final exact = messages[text];
    if (exact != null) return exact[index];
    if (text.length > 4096 || depth > 2) return text;
    final cacheKey = '$language:$text';
    final cached = _cache[cacheKey];
    if (cached != null) return cached;
    for (final template in _templates) {
      final match = template.pattern.firstMatch(text);
      if (match == null) continue;
      final translated =
          template.values[index].replaceAllMapped(RegExp(r'\{(\d+)\}'), (m) {
        final position = template.indices.indexOf(int.parse(m[1]!));
        final argument = match[position + 1] ?? '';
        return argument; // Server names, quantities and personal data stay verbatim.
      });
      if (_cache.length >= 2048) _cache.clear();
      _cache[cacheKey] = translated;
      return translated;
    }
    // Unknown content from the server is not machine-translated or modified.
    return text;
  }
}

class _MessageTemplate {
  _MessageTemplate(String source, this.values) {
    final buffer = StringBuffer('^');
    var end = 0;
    for (final match in RegExp(r'\{(\d+)\}').allMatches(source)) {
      final literal = source.substring(end, match.start);
      specificity += literal.length;
      buffer.write(RegExp.escape(literal));
      buffer.write(r'([\s\S]*?)');
      indices.add(int.parse(match[1]!));
      end = match.end;
    }
    final literal = source.substring(end);
    specificity += literal.length;
    buffer.write(RegExp.escape(literal));
    buffer.write(r'$');
    pattern = RegExp(buffer.toString());
  }
  final List<String> values;
  final List<int> indices = [];
  int specificity = 0;
  late final RegExp pattern;
}
