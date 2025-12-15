return {
  interaction = "chat",
  description = "Nextjs Modifier",
  opts = {
    is_default = false,
    alias = "nextjs",
    is_workflow = true,
    ignore_system_prompt = true,
    adapter = "copilot_claude",
  },
  references = {
    {
      type = "file",
      path = {
        "package.json",
      },
    },
  },
  prompts = {
    {
      -- We can group prompts together to make a workflow
      -- This is the first prompt in the workflow
      -- Everything in this group is added to the chat buffer in one batch
      {
        role = "system",
        content = function(_)
          return "作为一名资深的 Nextjs 15 开发者，您的任务是根据用户的提示词设计和修改 nextjs 组件，确保它功能完善、代码整洁且遵循最佳实践。"
            .. "在生成代码时，除非另有说明，否则始终使用来自 package.json 文件中的最新版本的 shadcn ui 组件或库。如果您使用了任何 shadcn 组件，请不要忘记告诉我如何通过 npx 和 pnpm 的方式安装它。"
            .. "尽量仅修改当前 #viewport 中的组件，如果需要修改其他文件才能完成任务的话请不要修改，先提示我提供哪些 buffer 引用，下一轮再修改。"
            .. "如果该组件是客户端组件，请不要忘记添加 'use client'"
            .. "仅使用 tailwindcss 进行样式设计。不允许使用 CSS 内联样式，遵循响应式设计和移动优先原则。"
            .. "仅当您看到用户的请求需要图标时，才可以使用 lucide-react 和 react-icons 包。"
            .. "仅当您看到用户的请求需要动画时，才可以使用来自 motion.dev 的 framer-motion (motion/react) 包。"
        end,
        -- 详细规则
        -- state management ?
        -- react-hook-form + zod ?
        -- 设计规范?
        -- 样式 间距，颜色，字体，字号，行高，阴影，圆角，边框，背景色，hover，active，focus，disabled
        opts = {
          visible = false,
        },
      },
      {
        role = "user",
        content = "我想要",
        opts = {
          auto_submit = false,
        },
      },
    },
    -- This is the second group of prompts
    {
      {
        role = "user",
        opts = {
          auto_submit = false,
        },
        content = function()
          -- Leverage auto_tool_mode which disables the requirement of approvals and automatically saves any edited buffer
          vim.g.codecompanion_auto_tool_mode = true

          -- Some clear instructions for the LLM to follow
          return [[### 指示步骤

@files 请严格按照以下指导方针执行任务：

1. 在 `app/playground/` 文件夹中找到 #viewport 中该组件的 **测试文件**。 该文件通常保存在`app/playground/ + 组件名称` 内。
2. @files 修改该组件的 **测试文件** ，根据组件的最新修改，写出测试事例。调整布局和样式，使其具有视觉吸引力且用户友好。该页面将采用简洁明了的设计。
3. 打印测试URL供用户查看结果。URL通常为`http://localhost:3000/playground/ + 组件名称`。
4. 我使用的是Mac，所以@cmd_runner只需调用`open + URL`来打开浏览器。

不要帮我安装依赖项，只需提醒我需要它们，我会自己安装。
]]
        end,
      },
    },
  },
}
