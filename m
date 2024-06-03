Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EED13C805
	for <audit@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=ooBjNOWlAeLYDNH0kW995UOtYGLmrF4AqMGAQS0ljqr3HxeRgOD39MKn2qRj0MaaVVEMOYvDohgxi2fKVG0hpb95MaePyO1NKHgfkcZ5VpVZ78QHTj1GcZsfsXK3tD+m3PnR8nkY9NY1jfrkUvxIhpc3MtxaXS7yZO5r1IDmxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1eI4ZhZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1eI4ZhZ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a196134d1so5613551a12.2
        for <audit@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450949; x=1718055749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=N1eI4ZhZlPjf68UnhLGKgEctRtMjOntNIkVhWbizskPmuiRECFIehLROdwxyzTQ9AH
         S9cP0MBrkfaqe7srvrEyx01OYady8bCw+zGe0+e6RweNuBb176fwD8b5ZT0cNBTt5D0R
         vn7DjORx+6oRGzNKhQi4sA6ri3UvO20Z+ast4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450949; x=1718055749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=QYptvudWjUmrFagUJ1TgEXYLkbfsfPrK1PYtiIW/7e5+WwkSiqwAyfI+e67Xxg0E16
         psaKluU/MVwB9/QIw3kKIAe091Og2dFuqs031AdF2yRbUTcyk9CexmKeOQ/GypXTnauq
         NhfDxeHs3s2UMj3OVcb4sutkjZL2esUNam0HM4N8H+FOWnbRv70FocMD1204e6nMvFxv
         +zJbkGsJrgviD01Yjuy/0aLkm3YlPag1etm31YJE435TF0xObhNlaf1RHAYhv6eIAvyk
         ViF/GJ0ZZ18C0Mb7Az0bzO5HjAzned1EDQNNMnwQiU7zGjOKbksYm2IdRgZDpv4/CJ/F
         OHjw==
X-Forwarded-Encrypted: i=1; AJvYcCUiDn1OY3XtDLBkLizEy/xXHgVg0B8RD67qTmgd2fRbk8fvoZBkM18X4DUsyhwNnfirPvoff8o8oBIXxTXAhJIG9jRp36A=
X-Gm-Message-State: AOJu0YwuZib0Xs6QEyVOl6ne0eESf6R7WIS58LZULv4WdQUZQV3Ze+jM
	F2rOlP2duDcrWKUSZNnm0jTK5NoprDGnky3ueUWs1+m3LcbXfYyvySGXso8dz8EbJUsTVXhkE+l
	sDOA=
X-Google-Smtp-Source: AGHT+IEfQ8S6fck2qnSJIjrn7q2ieB3ywlvowx/O5Nyp3BwuK5ClD27+3zsPr7afDF6YCw3DuSwmpw==
X-Received: by 2002:a17:906:a1c3:b0:a66:dca6:43f6 with SMTP id a640c23a62f3a-a6820136b23mr764907766b.27.1717450948741;
        Mon, 03 Jun 2024 14:42:28 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a687cc4e903sm496289666b.216.2024.06.03.14.42.27
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6267778b3aso436309466b.3
        for <audit@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6iDP8hjCOzjpYXsQmcHhJwvSXKfwD8efpbLmDM4/kVZ6Ju4GJ7GADyyfkqQXrnjSQTLa0I0+wRxJvwH+LG9BN8TlZtVs=
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus
