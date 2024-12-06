Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020A206F1F
	for <audit@vger.kernel.org>; Fri,  6 Dec 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490020; cv=none; b=P2KbG4CsjQOwNIh2U5wSlRtr0K6NyENxeDJD/DATiRVsP7qVPBhAXjYWwaUT7VpfaGxAUyUcRqMNEtMh0/eT49xpn2xM2fxW6epo4fcs83LTIAq53l39KvDd2ofi/eD6QHiFY9+P6eh8k+yq/Ac9PA71rIKMUMs2XJ9RcnxtC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490020; c=relaxed/simple;
	bh=PW6Q+/r8QRjgroTX3+KWZFperSsUGEs9C/zFXUin/3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FluepPbywXt+zKcn74SKXwJZ3f9jhkWq2pk5WdV6AcIVbdlxVE8FUBkkpT6t12SAk9Ij2LNUEsgXws9iJTRLkFjXnuvZG3f2pLLtVuPnlUAvSg//ZoeMzu/Xsx6rEpApuGp3KnhNB+ES0tAKIUy+7WwMefNOvoZCZ6ukcRAX5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cw8rDrjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw8rDrjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733490017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4np2Gt/G625+NVUj+saJleDuMjAPrEfkQvrELJ5U0PA=;
	b=cw8rDrjOA9xx08Z24SRJOvlwg9bhlKb8W9FbLeTSOccAOE+NaGjTEpJdsDTpy4n3r9og5q
	/gMEYHLVGtZnyCi9X2J3po+WzjpYgTd09YW90UQHyzxpWmq5Do79ZEAFYlXUaT5gae2FmW
	tgtGb6gXrpur4uw7G97lG7GHNHznFCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-GsDpl5v5OmidqcbG31yZCQ-1; Fri, 06 Dec 2024 08:00:14 -0500
X-MC-Unique: GsDpl5v5OmidqcbG31yZCQ-1
X-Mimecast-MFC-AGG-ID: GsDpl5v5OmidqcbG31yZCQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa64275c4f6so23228566b.0
        for <audit@vger.kernel.org>; Fri, 06 Dec 2024 05:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490013; x=1734094813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4np2Gt/G625+NVUj+saJleDuMjAPrEfkQvrELJ5U0PA=;
        b=pEOCIcLObUXocGm8nbU4AeVoL7iYGoXjmR+aiad9ACgTagjLfZHTBD6+NOlTSvXlsF
         tBvqQJ0AhzBFyjwDGFtvMrlTg6788OF/71eRIe9lk9+DndHYmsbWArlT+UWWn0yJ71IJ
         RfgCyPBJvEztQsL30UrLvEenvaIU0OdKTS7f6p930An+FZguk36jFHDIUcJdTACq4P16
         jbXEDGD+J1WIwe3P+FbG2sxfaUVo3gec2Ub+VdSm0avmXaZSOyH+d2XbLEGCzG4w7ksD
         2aIN1dOF/hwF9eDn226vO95WJWKgM1T9xFC80y7g4Vm3jh1ma3dIOEjqkz52uEh+INRa
         6wgA==
X-Gm-Message-State: AOJu0Yxu2p3yTk8f0lVlmxIG/reGNEIV4OXUIF59jPxdGNZpMddsLAQF
	1FFE5GH70/u11rsBKJ08UbahXeJPpunYmoLrmXfnX50uR0oT8ueRO8mDrhGUBSIhc75JR8NMG+F
	1WMQRhadb/Uac5WurqfZlN/DL6tYNa5rysmHKIfKVhu605AvO3B0HYkuJ8/5hJ0trVY4o9kqDnH
	74SIjUDLsaP8N3+sj0st24wrJ+93o=
X-Gm-Gg: ASbGnctPGAYI5FnF0BoBL3zOOMJt8DxAWvanqsUVlnf0XStl9AzgdW3IGN0N4zXENom
	vPsRxeVFxnP9+o3fmGsefS+vNXxkjR77D9XOsONKXzuHcL5INKnCZXXhjAHpXOaYE
X-Received: by 2002:a17:907:910d:b0:aa6:3e97:f9db with SMTP id a640c23a62f3a-aa63e98157emr128921666b.50.1733490013099;
        Fri, 06 Dec 2024 05:00:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGbiJ4az96p6Wq62FXctxA12RJ2DsEtqG6ZgCij4WznqIqqVnc0rVhUWkKSVx3XxBChHE/U3LahunxkzQ4SqU=
X-Received: by 2002:a17:907:910d:b0:aa6:3e97:f9db with SMTP id
 a640c23a62f3a-aa63e98157emr128920466b.50.1733490012718; Fri, 06 Dec 2024
 05:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122121843.641573-1-rrobaina@redhat.com> <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
In-Reply-To: <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 6 Dec 2024 10:00:00 -0300
Message-ID: <CAABTaaBQ0+tSx++xYB2NJ=3Qkein9Y5=eY0uU-V9Qb6mR28GvQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, viro@zeniv.linux.org.uk
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NFTNawvl7QAHLCUVsJPQYHz6uKNANdycTkLJaST6EQ8_1733490013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Yes, Richard did provide a reviewed-by tag on the v1 patch, but v2 has
> enough changes that I don't think we can reasonably carry that forward;
> of course Richard re-review this iteration and provide a new tag.  I'm
> going to remove it for now.
>
> Al never provided an explicit reviewed-by tag; simply commenting on a
> patch is not the same as providing a 'Reviewed-by', the reviewer will
> provide an explicit 'Reviewed-by' tag in their email.  I'm going to
> remove Al's tag too.

I'm sorry about that, I was just trying to give credit to the ones who
helped. Thanks for clarifying the expected review process, I
appreciate it!

> Other than those issues, I think this looks much better than v1, I'm
> going to merge this into audit/dev now, thanks!

Thanks, Paul!

- Ricardo

