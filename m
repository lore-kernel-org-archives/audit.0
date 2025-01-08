Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9087203713
	for <audit@vger.kernel.org>; Wed,  8 Jan 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351060; cv=none; b=Vz0yweelDBDYGy0Qa+MlIfb7mbFep/Hz8/WKzmO2UwHJcl6UGXSSlzdqjhO+BY/3gMoMT7MOId7o3PItQMZbuEyNAHM57LB4+kYmCFgpH9CYJVMLBIzEr/xNkpdQKBJ8fZ2QFzTIXDbR3pO24fJVNGgGbwycRBZRY3w3NjH0lzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351060; c=relaxed/simple;
	bh=UXseJXwoe8+TQHvxbQCzNTz7uAEXL80tPcLYA+qIUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfridndaFhdm5tkqigEUWkc5tv5JnZzfL+naLBoOsqS7jIVCQEdk+nRDyiWjRliitR3A9tjgZky8AzzEtCtuG+cNmdq+hnTKFaVZ/eRPEdy2aAR6nk4sv7FCJAtHdnrwXoeHUoGJM6ULLTxl+4tPUqdVtUV1GfhEv6ckm0knyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ncxqaA20; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ncxqaA20"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfR1QXDzmPT;
	Wed,  8 Jan 2025 16:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351055;
	bh=UKmay/IzTxgyZVsCRBq/9xe8WuOCLbcexgf3Mv/t7gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncxqaA20ytBUF5Q9qWZDiMMYjiX/eYWei/E2CUMv8rv0d+7IA1PYvvS5zlUl7h0U/
	 0EW2yhN7oz6TqriCnLA5oF7hHYGR7J/9g9c3n464tm5VKdATfDBJ17cxuxRuxmanQC
	 T4NVBlBrpCz5INY0nrL11BZ6QyLtzqz20ZiHJ524=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfQ3C2Bz5Lp;
	Wed,  8 Jan 2025 16:44:14 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 19/30] samples/landlock: Do not log denials from the sandboxer by default
Date: Wed,  8 Jan 2025 16:43:27 +0100
Message-ID: <20250108154338.1129069-20-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Do not pollute audit logs because of unknown sandboxed programs.
Indeed, the sandboxer's security policy might not be fitted to the set
of sandboxed processes that could be spawned (e.g. from a shell).

The LANDLOCK_RESTRICT_SELF_QUIET flag should be used for all similar
sandboxer tools by default.  Only natively-sandboxed programs should not
use this flag.

For test purpose, parse the LL_FORCE_LOG environment variable to still
log denials.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-20-mic@digikod.net
---

Changes since v3:
- Extend error message, suggested by Francis Laniel.

Changes since v2:
- New patch.
---
 samples/landlock/sandboxer.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..f132869f55f5 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -288,7 +289,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 6
+#define LANDLOCK_ABI_LAST 7
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -315,6 +316,9 @@ static const char help[] =
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
 	"\n"
+	"A sandboxer should not log denied access requests to avoid spamming logs, "
+	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
@@ -333,7 +337,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	const char *cmd_path;
 	char *const *cmd_argv;
 	int ruleset_fd, abi;
-	char *env_port_name;
+	char *env_port_name, *env_force_log;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 
@@ -344,6 +348,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 	};
+	/* Do not pollute audit logs because of unknown sandboxed programs. */
+	int restrict_flags = LANDLOCK_RESTRICT_SELF_QUIET;
 
 	if (argc < 2) {
 		fprintf(stderr, help, argv[0]);
@@ -415,6 +421,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes LANDLOCK_RESTRICT_SELF_QUIET for ABI < 7 */
+		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_QUIET;
+
+		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -449,6 +461,23 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
+	/* Enables optional logs. */
+	env_force_log = getenv(ENV_FORCE_LOG_NAME);
+	if (env_force_log) {
+		if (strcmp(env_force_log, "1") != 0) {
+			fprintf(stderr, "Unknown value for " ENV_FORCE_LOG_NAME
+					" (only \"1\" is handled)\n");
+			return 1;
+		}
+		if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_QUIET)) {
+			fprintf(stderr,
+				"Audit logs not supported by current kernel\n");
+			return 1;
+		}
+		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_QUIET;
+		unsetenv(ENV_FORCE_LOG_NAME);
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
@@ -476,7 +505,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
 	}
-	if (landlock_restrict_self(ruleset_fd, 0)) {
+	if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
 		perror("Failed to enforce ruleset");
 		goto err_close_ruleset;
 	}
-- 
2.47.1

